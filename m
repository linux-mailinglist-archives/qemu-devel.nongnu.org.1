Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BEF754355
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 21:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKOef-0006Iz-4s; Fri, 14 Jul 2023 15:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qKOea-0006Hs-64
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qKOeX-0004mg-MF
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689363633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7JAsij8hB3O4SojcpxmQF1nnT8HBylZgOPyDV1M1d8=;
 b=ZU+UnXikUQINezPjQvwKPW31GOvMnHdimg6iT3qZ7gMF82wXuFOZLsDb3Rbad4XlosChXE
 7b9usV2xlbI19UGjxXefboc8D1oCvxss+M+K+FXTzapsDMD5svw2+83wnI4beoFSjtK9w6
 mQ9vD+VmqzrFJIez9NIie/j6/VxqZ0E=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-DGEbDvjNNLS89JZcIS7pBg-1; Fri, 14 Jul 2023 15:40:30 -0400
X-MC-Unique: DGEbDvjNNLS89JZcIS7pBg-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-786d9d4d9a6so97164639f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 12:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689363630; x=1691955630;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e7JAsij8hB3O4SojcpxmQF1nnT8HBylZgOPyDV1M1d8=;
 b=kXrwVDV1Oy+2QE6IdNrf/aqdjEWC/SA8sAPD+RoHRdh+2U97zgLhxkEoW5zcz19zJh
 GOQAeT1uJu9BPFyHI8+TKtszEmfVGdlABPzpdlOoTRTaYKcWmjNb6fZL1JrpSQHpEZD9
 QK42WVH01wWlfRaPb4gFoUOhL/tV24U1hnlJe8cJ3u8Yjli+usCzfYwVPoU1SG3HTc0I
 5nmGzisbKalhly3Iks2KtjZGh0PkLG2EVNrmX8cp3mP5aQPOOVOuf2mHAHzfHEsSEZGR
 CnGrgEFk5qdeFS2vG+laNxHO1MBNuiPdBsZ7/NYg3pR2d+b/wbk1AWXswWg1N4fIlBx+
 FudQ==
X-Gm-Message-State: ABy/qLbJJmdvKdvphcxS25l32BK31IFNz1C5lzzXxzP+HhdJfWF+v4Ob
 1sI6gcXU6DK4y96NG6kUuFeodNyXIhAw9vq1s28LMoIrd4lTPazUwKXSyvlkf2dPljX6ke8UNZb
 2vYvP2br+6slvyos=
X-Received: by 2002:a6b:e80c:0:b0:780:d031:bc42 with SMTP id
 f12-20020a6be80c000000b00780d031bc42mr6548454ioh.16.1689363629901; 
 Fri, 14 Jul 2023 12:40:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENeThG68pvLNBRaQXdpWrlPn8xq7CUuk4Byx+pCFvwFw5ClDk0hz+RgDh6cD6+MwEd9QdnTQ==
X-Received: by 2002:a6b:e80c:0:b0:780:d031:bc42 with SMTP id
 f12-20020a6be80c000000b00780d031bc42mr6548416ioh.16.1689363629575; 
 Fri, 14 Jul 2023 12:40:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 x3-20020a6bfe03000000b0077e40979b41sm2836306ioh.45.2023.07.14.12.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 12:40:29 -0700 (PDT)
Date: Fri, 14 Jul 2023 13:40:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] treewide: spelling fixes in comments and some strings
Message-ID: <20230714134028.2c987970.alex.williamson@redhat.com>
In-Reply-To: <849f5b3a-33cd-3406-4462-90ac11bcde96@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-3-mjt@tls.msk.ru>
 <20230714122201.3b118f40.alex.williamson@redhat.com>
 <849f5b3a-33cd-3406-4462-90ac11bcde96@tls.msk.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Fri, 14 Jul 2023 21:50:01 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 14.07.2023 21:22, Alex Williamson wrote:
> > On Fri, 14 Jul 2023 14:38:06 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> >   
> >> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> >> index d8aeee0b7e..12e7790cf6 100644
> >> --- a/hw/ppc/spapr_pci_vfio.c
> >> +++ b/hw/ppc/spapr_pci_vfio.c
> >> @@ -39,7 +39,7 @@ static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
> >>   void spapr_phb_vfio_reset(DeviceState *qdev)
> >>   {
> >>       /*
> >> -     * The PE might be in frozen state. To reenable the EEH
> >> +     * The PE might be in frozen state. To re-enable the EEH
> >>        * functionality on it will clean the frozen state, which
> >>        * ensures that the contained PCI devices will work properly
> >>        * after reboot.  
> > 
> > This looks like personal preference, I can't actually find a source
> > that indicates "reenable" is anything other than a valid alternative of
> > "re-enable".  Thanks,  
> 
> Well, it was one of the questionable suggestions from codespell.  I like
> the re-enable better but in this case I don't really care for one way or
> another. I can drop this and other similar fixes. This one definitely
> does not hurt my eyes when I see it ;)
> 
> $ git diff qemu-master..spelling | grep -c re-enable
> 8
> 
> I can drop those 8 out of 400 :)

If we consider codespell to be the authority I guess we can leave it,
but it seems a bit pedantic to me.  Thanks,

Alex


