Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91E74844D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1kv-0007XV-J3; Wed, 05 Jul 2023 08:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qH1kn-0007Vl-T1
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qH1kk-0003j9-SF
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688560621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/JBDa9TvIRPsQJyRs/FLhAyGnTuoL6L+K+hMPCvjn8=;
 b=Vm548EaoBJEvC6+NxdWEhcNDvnhpsruD8UWuG7kWBL3gU4Op0o8dhdzyH1bYooV40o0ryn
 PcZZv/AskdPCTCD/yF53+ntjan2NmluoyJMBC/tARS67UIRcOhCUHG+DnJQqohhf7XFKce
 lkDZeOYwctwf7AaCm1GKX2M24edAKoo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Yew22b4UN8WTZ0uc-nO0QA-1; Wed, 05 Jul 2023 08:37:00 -0400
X-MC-Unique: Yew22b4UN8WTZ0uc-nO0QA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76746f54ba9so633434885a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688560619; x=1691152619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/JBDa9TvIRPsQJyRs/FLhAyGnTuoL6L+K+hMPCvjn8=;
 b=fS5PsOWaVxaG5nLNPPCiVtZ7H9OCWwKM1Zed6Gz/+e7q5bG582taBO7UPzK1L10ZVp
 EgbXBOlyGlSpAVMEATB771CF+azCdiQAcrAdTkfcruQr+3LAUFJYaszLFJBfHuQkGmDN
 SSdMMtO4T7Usk4XPLXGGk7iEYwDtNVZs96e+3wIamN/MZYModMnF27DATXIl+PwRJybL
 aexiDE5Y0IcqQPOErVnBL6t3NWDb2aOnpLtw0BbnClKvsnM9bPZlMvBxTGTTjTmeqXhH
 //R/Z/kWvJMBRGugcT6rsb0nKhWTIDUA3+3I61tQtrVfKl/4TVuoZTRjRPEsJIsnoHuS
 0OSA==
X-Gm-Message-State: ABy/qLaw9KUG3niHNEQbgBjk/HPXtPCOYjsTE9sr1apMAY/r4vrwBWLp
 wgyCEdKhJtshJd9hyDgnpuVVuj19mlZ0uZWwSgLCcp27srkCwYMypu3c5ZuSXzsY37WsIxIWGCs
 F7MnEjLsFLd2K3es=
X-Received: by 2002:a05:620a:4611:b0:767:494f:4ab5 with SMTP id
 br17-20020a05620a461100b00767494f4ab5mr17892482qkb.39.1688560619494; 
 Wed, 05 Jul 2023 05:36:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG2S853ttHcmmvP2lRhl1jROrATWL4PzJpJ8G2UYFpDktHR8FirG9Jv0vXmxVM+uxKaQXsfnA==
X-Received: by 2002:a05:620a:4611:b0:767:494f:4ab5 with SMTP id
 br17-20020a05620a461100b00767494f4ab5mr17892462qkb.39.1688560619224; 
 Wed, 05 Jul 2023 05:36:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 a22-20020a05620a103600b007677e20f179sm1989374qkk.7.2023.07.05.05.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:36:58 -0700 (PDT)
Date: Wed, 5 Jul 2023 14:36:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <ujzth6z2w5cha3h4hbw6jufgux3phaaqc67zdn6obypwnmbxd2@qqssco2tgvwk>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <3adcc3c3-c0ba-0810-10b6-b13ac36a5de9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3adcc3c3-c0ba-0810-10b6-b13ac36a5de9@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Mark,

On Wed, Jul 05, 2023 at 07:28:05AM -0500, Mark Kanda wrote:
>On 7/5/2023 2:15 AM, Stefano Garzarella wrote:
>>This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
>>
>>That commit causes several problems in Linux as described in the BZ.
>>In particular, after a while, other devices on the bus are no longer
>>usable even if those devices are not affected by the hotunplug.
>>This may be a problem in Linux, but we have not been able to identify
>>it so far. So better to revert this patch until we find a solution.
>>
>>Also, Oracle, which initially proposed this patch for a problem with
>>Solaris, seems to have already reversed it downstream:
>>     https://linux.oracle.com/errata/ELSA-2023-12065.html
>>
>>Suggested-by: Thomas Huth <thuth@redhat.com>
>>Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
>>Cc: qemu-stable@nongnu.org
>>Cc: Mark Kanda <mark.kanda@oracle.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>

Thanks for the review.

By any chance do you have any information you can share regarding
[Orabug: 34905939] mentioned in the errata?

I'd like to better understand why this patch created problems in Linux,
but solved others in Solaris.

Thanks,
Stefano


