Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D780E6ED
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 09:56:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCyXL-0006zk-8A; Tue, 12 Dec 2023 03:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCyXJ-0006zU-Hc
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCyXG-0005hp-PF
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702371272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+ddurBHN05IoCwUUUuMVZrcU7oydq2xNnTKvJQOUxk=;
 b=DYZ+yxqxw5dX5wvrFKnKEYfzMX5YvvDCsAv4i0L3dT9uX5bqKjssBujvmUZMLSRRcSDdua
 kOlKtyH8rCtT4fmJlvTtsynFVOfUlUNcHpqXlOsMTYq/MbWSf3RTSmN5DvE/qcoAykQUXD
 CCIerj0NNJafpce6AFHl/JpBE2QY3kg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-nEtVXtz6NP-XoQ_fCt_CvQ-1; Tue, 12 Dec 2023 03:54:30 -0500
X-MC-Unique: nEtVXtz6NP-XoQ_fCt_CvQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1fb3299777cso1164319fac.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702371269; x=1702976069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+ddurBHN05IoCwUUUuMVZrcU7oydq2xNnTKvJQOUxk=;
 b=Vm6NKh0zrhfD6fl6oOQQ1yRnHLU7/6m9az1c2626VutJN50JiXWe4a8x9dFxUIJHH4
 ShpTgSE0w5T1WlGoS2gCiHrQscx58NjPsBoHBWKLHj0I6sRy15K3a5RSp+30K8ADtEGc
 rp36JtEMwMOxmSdusTxRroWVgxOu1mdNz4Gb60wdkkIJ2vFEpwUOpsDILHRlRotSEi1+
 TvEJRY62h3V6NhgDtaUQjh6FHAfvs65PJZuvrur6TNlpO2usQ2EuZgfxtopHPhVhTodE
 NMsTelaw/rLvO/qYw0MjRMFnsbCT1zqGZXyJcWh/ICg75+mcH8SbFhfvp/KyDVtlBKbV
 baSg==
X-Gm-Message-State: AOJu0YwD9oLu+/9wmt9jfYyV0AbyzmZOfxiXcZCqZm+aicIQaLsfP2ei
 rAzpVYiIt0X4I2SHjU+Q15THI3A2uy/X7Nc+7l62iolp6zu/ueO1O+K7CI/Dx7M1LFZD19OB5eB
 wsROQywnUMBwQKAw=
X-Received: by 2002:a05:6870:79d:b0:1fa:60b0:9d9 with SMTP id
 en29-20020a056870079d00b001fa60b009d9mr10359991oab.1.1702371269447; 
 Tue, 12 Dec 2023 00:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV/KiWn9mOrS0suTNzTJ1I8GXOqvdCRsZDno28UQ374wmNL/QR8eXO2a/hGg6XZZOjoMd6mg==
X-Received: by 2002:a05:6870:79d:b0:1fa:60b0:9d9 with SMTP id
 en29-20020a056870079d00b001fa60b009d9mr10359977oab.1.1702371269167; 
 Tue, 12 Dec 2023 00:54:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i1-20020a6551c1000000b005c6e8fa9f24sm6659449pgq.49.2023.12.12.00.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 00:54:28 -0800 (PST)
Date: Tue, 12 Dec 2023 16:54:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 00/12] fix migration of suspended runstate
Message-ID: <ZXgfvXLoKW1Q50Yp@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <e7b55ad1-88a0-4d0c-9f4a-2df92ee4ff16@oracle.com>
 <ZXaytc6glZWRC8O9@x1n>
 <e96986f5-6e7a-4c78-a016-057a98d9a3f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e96986f5-6e7a-4c78-a016-057a98d9a3f5@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Dec 11, 2023 at 08:31:17AM -0500, Steven Sistare wrote:
> On 12/11/2023 1:56 AM, Peter Xu wrote:
> > On Wed, Dec 06, 2023 at 12:30:02PM -0500, Steven Sistare wrote:
> >>     cpus: stop vm in suspended runstate
> > 
> > This patch still didn't copy the QAPI maintainers, please remember to do so
> > in a new post.
> > 
> > Maybe it would be easier to move the QAPI doc changes into a separate
> > patch?
> 
> This was intentional.  I did not cc them for the whole series to spare them from
> excess email.  You cc'd them for "[PATCH V6 03/14] cpus: stop vm in suspended runstate" 
> they had no comments, and there is no change for V7, so I assumed we are OK, but I will
> cc them again for that patch to be sure.

Yes, please do so.  Per my experience on QEMU, we normally need an ACK from
all sides to merge a patch.  There can be outliers if the changes are very
trivial so one maintainer may just pull that in, but it'll always be good
to always copy relevant maintainers.

Thanks,

-- 
Peter Xu


