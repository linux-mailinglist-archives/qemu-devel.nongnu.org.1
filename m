Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007377D0230
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYJx-0006NE-Rc; Thu, 19 Oct 2023 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtYJv-0006Mn-D0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtYJt-0002Bv-FQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697742272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bTn3mbFPz2KBz6sXq55CUvJvidAK/zbjZNSlWVpeGp4=;
 b=N5BNp5MwL9dYHKelWmbmXFyJwKoMHhiFy3jsxRYvyZg+6rYRDF3xwjUjraNNWr2KVOLz5b
 6t0qvjABbG/QcwqS6zPmbGi8uWL+dYLZONdo/iNJHDpOy2iPKTccVbzy9EXp24T2SX5a23
 0CrWOajVXT4ZCxzWw9nrAsb70zy04/I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-LexgxHrPOd2jx19BGfxjFg-1; Thu, 19 Oct 2023 15:04:30 -0400
X-MC-Unique: LexgxHrPOd2jx19BGfxjFg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d2fdf80beso179376d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 12:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697742270; x=1698347070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTn3mbFPz2KBz6sXq55CUvJvidAK/zbjZNSlWVpeGp4=;
 b=pD8x05WVrwHHDqd0u9vBvSkFJCcfNKqJa9WFwhbH5kNSERHVMzcyFhrQ1qZcQrWAAM
 vuMINhzQdHLzxKu02W9PPpDCntHL6cISCcv+H2o7OGrlVB6hQYaMsgTM4j5r19fTKcYR
 u97ne75n3zREJ6Jh9hqC6FMTEEx38GfQLXisjUdQwfWfVF/rXsWwp9Ux4yTi47Aag5i3
 NVHN8eyLQ5z5dpWBnjUDeYwiq7forlN9qRE6iAsuQz188EDuaxwn8RkZ0QD1htHdB4ao
 PHRaXBxsB+xn+8VgRk6pTrLvJx7gcLI6BadMyt6PN/KatWi/v/6h2YXeuG6Szbstn2XH
 CW/w==
X-Gm-Message-State: AOJu0Yx0DXm36f1Adk2Uc080bxb2fI8T2hG8iDM6j5kyFio9rANVDCyy
 oDop3TW8xJ9ohYPTafKpD93YLSESJHHpwY0iznwIGpOtlb9u+IEtabCIEmIpuEky91iK4ycaaaD
 qE2JRvnTW0IIAGYU=
X-Received: by 2002:a05:6214:3a81:b0:66d:6111:5c5f with SMTP id
 nz1-20020a0562143a8100b0066d61115c5fmr3294563qvb.2.1697742270291; 
 Thu, 19 Oct 2023 12:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ6TaWdh/w3/TdJWwxU7J8EWMhvpCLPbSITyD8tyN//vPY24zV2kFLFMEh2zara8K7hApzrA==
X-Received: by 2002:a05:6214:3a81:b0:66d:6111:5c5f with SMTP id
 nz1-20020a0562143a8100b0066d61115c5fmr3294552qvb.2.1697742270039; 
 Thu, 19 Oct 2023 12:04:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 dr20-20020a05621408f400b0065af24495easm77327qvb.51.2023.10.19.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 12:04:29 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:04:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
Message-ID: <ZTF9vL8yyn6McuTx@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <87r0lqy83p.fsf@suse.de>
 <87wmvi3akc.fsf@secure.mitica> <87lebyy5ac.fsf@suse.de>
 <87a5se3161.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5se3161.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 19, 2023 at 08:41:26PM +0200, Juan Quintela wrote:
> We can changing pending_job to a bool if you preffer.  I think that we
> have nailed all the off_by_one errors by now (famous last words).

Would it work to make pending_job a bool, even with SYNC?  It seems to me
multifd_send_sync_main() now can boost pending_job even if pending_job==1.

That's also the place where I really think confusing too; where it looks
like the migration thread can modify a pending job's flag as long as it is
fast enough before the send thread put that onto the wire.  Then it's
unpredictable whether the SYNC flag will be sent with current packet (where
due to pending_jobs==1 already, can contain valid pages), or will be only
set for the next one (where there will have 0 real page).

IMHO it'll be good to separate the sync task, then we can change
pending_jobs to bool.  Something like:

  bool pending_send_page;
  bool pending_send_sync;

Then multifd_send_thread() handles them separately, only attaching
p->flags=SYNC when pending_send_sync is requested.  It guarantees a SYNC
message will always be a separate packet, which will be crystal clear then.

-- 
Peter Xu


