Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90301742C8E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwrb-0005YX-3p; Thu, 29 Jun 2023 14:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEwrX-0005Wh-Hl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 14:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEwrV-0004eI-Td
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 14:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGV51lUZuN7S2eNIc80E2bTW7N9bLFAzJ/ySDyn1dbI=;
 b=WXAvzpaAxwa+4E7cOiYmwrXpdzXdesQ68LoIa2V1oyEghV8Mwwuexxm0WZjOFUC/PXGbtj
 20qiJbuVmDnhRdbWRPiIsb6z8hC50GwWn2nqI0HkAfFsCGuO6odVF+7QQ4DCipdwpqY5xs
 iQefl7+8UsZpwRLK/TKSSYXnnDv8cPE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-olKKM_sPNoq3y83fbHIPWQ-1; Thu, 29 Jun 2023 14:59:21 -0400
X-MC-Unique: olKKM_sPNoq3y83fbHIPWQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62dd79f63e0so2176856d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688065161; x=1690657161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGV51lUZuN7S2eNIc80E2bTW7N9bLFAzJ/ySDyn1dbI=;
 b=HdK1OMQmAXiZ6lGg/yzNNdYmQSCPVaw7wqSXPLFa1BmHTul8K33NhqGQzdZYcJCSSB
 d01M7eWuB4b3V35pV8Yc2ao1Rl2NVvVSDp6qAPWIBKhuJYQJKotpRz1WEXF6JTyLWjwx
 lSNrWZD0p8Br8cv2FtR6FgWUo7VMGGuzlorlyY4CCdHAmn7jOcxSdzRm/VcH4cL8Uyk/
 /k62yn9yeOfVJqW/U3X9PyFvqs6JMUxGfJAmiwA1SIBAUbl9OTvKESuYFlyCSgBLC7fg
 UrrLjpiiF7s2MvO5MpVq9QQ6RtR4nbDucgHknCNtVbxvYaqVliRtARCxdJOTcWrPw7PI
 Hrug==
X-Gm-Message-State: ABy/qLYO7Nk7Y40Wjp98xGZMebQK2SWcRFhglNG2JcNxH4gsrJKGIuUY
 rjYkaxME0QIQwxtMSwOic/8jch2MpoJL4lTF7MZi3xnzolMhU5gpN5+m0ermA49YSfYbPbZP/cx
 I7MikwtHizc0UbvM=
X-Received: by 2002:a05:6214:d06:b0:62b:6c6f:b3e3 with SMTP id
 6-20020a0562140d0600b0062b6c6fb3e3mr529945qvh.3.1688065161337; 
 Thu, 29 Jun 2023 11:59:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwb1j56GjMe2C0Vg8Rq4FctM1LQPV+ZLmpFj3aa+DY74jrM8lOycLS2eCv6V787p0wtHai6A==
X-Received: by 2002:a05:6214:d06:b0:62b:6c6f:b3e3 with SMTP id
 6-20020a0562140d0600b0062b6c6fb3e3mr529931qvh.3.1688065160989; 
 Thu, 29 Jun 2023 11:59:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 kr30-20020a0562142b9e00b00635fcd30ff9sm2153092qvb.40.2023.06.29.11.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 11:59:20 -0700 (PDT)
Date: Thu, 29 Jun 2023 14:59:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] vfio: Don't be a iterable and legacy device at the
 same time
Message-ID: <ZJ3UhhX6ttNsDq00@x1n>
References: <3c45b84bf970d20bfc72865c4de5c33563c2b62d.1687430098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c45b84bf970d20bfc72865c4de5c33563c2b62d.1687430098.git.lukasstraub2@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 01:22:26PM +0200, Lukas Straub wrote:
> Legacy savevm devices only implement save_state() and load_state().
> Iterable devices shouldn't implement save_state() or else they are
> handled both as an iterable and legacy device in the savevm code.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> 
> Note: this patch is completely untested.

PS: if you're not confident on the change will always work, better mark as
rfc to show a proposal of such change.

Comparing to the "legacy" vs "modern" migration, IIUC it was about whether
to use vmsd, so it's "save_state()" vs "vmsd" in that regard.

Personally, I don't immediately see a direct conflict / issue with device
providing both save_state() and save_setup().  It means the device declares
both (1) iterable data, and (2) non-iterable data (which can be either vmsd
or save_state()).

I do think vmsd is still preferred here for (2), e.g., I quickly looked at
vmstate_vfio_pci_config which seems fine to be implemented as a vmsd, with
a post_load() perhaps.  But that's another story.  It just all looks still
fine.

Do we get any benefit from having that restriction?

-- 
Peter Xu


