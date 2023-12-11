Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97E80C197
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:57:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaE2-000400-9b; Mon, 11 Dec 2023 01:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaE1-0003zs-4f
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaDz-0001Uh-MP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702277825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McZG5hea3AixHIBFjexRgps+FD8v5WjUFctb9Jj4mC8=;
 b=KRawCbqsHiHazBl8HcZPZH189RQUgrA28voNSoK9gfVTK0JmgXm/nwSb60kJe1TEQdFFVx
 JMMtJ9HSxLumF5ht/Q4WMzBDFOYDgfXbI1ykZRxG1U6dL//yWcCAXJNoC5iLIplLpiNi9o
 WrIH5ipZZG18vPJYWSZ21455wr9RoK4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-_q8EEFAqNYaEmpzQBvHQFw-1; Mon, 11 Dec 2023 01:57:03 -0500
X-MC-Unique: _q8EEFAqNYaEmpzQBvHQFw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-286e9b8443fso1517299a91.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702277822; x=1702882622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McZG5hea3AixHIBFjexRgps+FD8v5WjUFctb9Jj4mC8=;
 b=KZaszImjtw0ep8O/S3E+mDo77Xt3MJTNbCLit8O/uf0cTHLSEHTEDywHTqr3BsSzJ0
 tQsskRrNiSWX9Qx/pSKeL9Da39JvrORE11Zc+QwdH5tD0stW3rO20wD7zrmTfqmZjz5H
 G3pjzAvMFj0djPJWcxfgf4dEscSj04KGW5Ietaa7CIs017mUmAhaV9r2HPZ/XUujuk34
 EC0Mnm5rndnDkmgBCNE8iY8xdFN+jgDjilr+AravSANUjwmn5eT9hML/LuWmHYUdcJjB
 r7/0hmZHL2yKZWoQ7MFoZAKp7YINPIdIgL2fheS+gaa+yk32nuwma1jF/u3GNNeg4p31
 ++Hg==
X-Gm-Message-State: AOJu0YyW+ohNl5uQpTSSnjq2FfrOL5MioWzQASahMSZcniVPJ+T3AiRU
 TvfSraddopIOX9ZbSRVRdZDbmdlcrJ0N/7KZB0w8BrDfLOoPlB0xySQuu0nifEC19tzzCVZzybe
 xNhHQeeEwfdqLIB4=
X-Received: by 2002:a17:90a:9a8f:b0:286:6ad8:5d15 with SMTP id
 e15-20020a17090a9a8f00b002866ad85d15mr6550038pjp.2.1702277822508; 
 Sun, 10 Dec 2023 22:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvYh6wfIfc8XP2HYSjeKRQnKQuq536+MhJORKg3mrhZd/aMNgSMuaTy3cVUeN7we0FWld7TQ==
X-Received: by 2002:a17:90a:9a8f:b0:286:6ad8:5d15 with SMTP id
 e15-20020a17090a9a8f00b002866ad85d15mr6550034pjp.2.1702277822212; 
 Sun, 10 Dec 2023 22:57:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s91-20020a17090a69e400b00285994be9easm7200983pjj.1.2023.12.10.22.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 22:57:01 -0800 (PST)
Date: Mon, 11 Dec 2023 14:56:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 00/12] fix migration of suspended runstate
Message-ID: <ZXaytc6glZWRC8O9@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <e7b55ad1-88a0-4d0c-9f4a-2df92ee4ff16@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7b55ad1-88a0-4d0c-9f4a-2df92ee4ff16@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Dec 06, 2023 at 12:30:02PM -0500, Steven Sistare wrote:
>     cpus: stop vm in suspended runstate

This patch still didn't copy the QAPI maintainers, please remember to do so
in a new post.

Maybe it would be easier to move the QAPI doc changes into a separate
patch?

Thanks,

-- 
Peter Xu


