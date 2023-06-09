Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C5729F50
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7eSl-0002DD-05; Fri, 09 Jun 2023 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q7eSi-00029k-He
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q7eSg-0005CZ-1K
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAFFkFsYUJIL9ImpIFyNHmDj+BYyAjm9metW8naB4+E=;
 b=Y8nGtvVIGdgrweETq2ML1cOaxiZfMdmFH1/0IdSCsSy6Mx5NgYg3vbMnYE47uNBhFzYcX6
 IoBiO2A9Div7zsZv0yNFfiljY9JK50uJTOM7o9VU51CjKaMkDmRaxAiLY3o2mF7IQERf5n
 c3MScIJlQqqpe4jAfsdznozdImo3LXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-WER0QFGePieuVKrbxkuFng-1; Fri, 09 Jun 2023 11:55:32 -0400
X-MC-Unique: WER0QFGePieuVKrbxkuFng-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f739cc1aafso9345115e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 08:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326131; x=1688918131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAFFkFsYUJIL9ImpIFyNHmDj+BYyAjm9metW8naB4+E=;
 b=Ys41CBFJ+pPuAa3iafLJw3O12Iheew/YzebHfIjqijXeaLbJjfT5EAnOxfZhDcmMAV
 BSzYCmxJ6kiP0FXx1Nni9OzwvJKzFeXk9V1m/1ozgO2jcOYtNtspWPmL/EnINzpBm5mB
 zM/kV103QdSdcq0ngmVP4t8Qs3Zwj2Rq7Wa89H116Ni1w4MxsdgM2vv827Oh+8T1/Ztg
 xemzfPZL6ecQ5vqckJAgSaXcDfZaGpBq8gcTm6uj2qIr81slfElBsKD3Oaxs6YqDFbHs
 I2/Xi7azS0gu6/qiT/J8M/JQKoQw/mnhRMeRfYEyKR2egi/RNXBGi0x42J5TeHbfuZCM
 fJ8A==
X-Gm-Message-State: AC+VfDwvajE5or+1R27H/OA+P9z95/JFDzwAH/7UwYQbwkel/VQ9uzqc
 K1jnyIlmKIAXykgPLMrQc8gHG4MwAaSDSIS62xb1shN18WiIfD45/R/ds4AgCnmGDWmF0ANZLxg
 3uondgCI3evFwFKw=
X-Received: by 2002:adf:ed90:0:b0:309:5068:9ebe with SMTP id
 c16-20020adfed90000000b0030950689ebemr1138373wro.50.1686326131671; 
 Fri, 09 Jun 2023 08:55:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cwTTwKxSYgN9ArMPkXIBaoHhs0B5qdSbc1wS/6KJFANrfl+LNfTwomUQij5ooRhgVwZTbVQ==
X-Received: by 2002:adf:ed90:0:b0:309:5068:9ebe with SMTP id
 c16-20020adfed90000000b0030950689ebemr1138361wro.50.1686326131339; 
 Fri, 09 Jun 2023 08:55:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 a3-20020adfeec3000000b0030ade1b9400sm4842239wrp.30.2023.06.09.08.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 08:55:30 -0700 (PDT)
Date: Fri, 9 Jun 2023 11:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v4 0/1] ROM migration
Message-ID: <20230609115508-mutt-send-email-mst@kernel.org>
References: <20230522201740.88960-1-vsementsov@yandex-team.ru>
 <5a9ed961-0356-33d0-21a4-42032621c13a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a9ed961-0356-33d0-21a4-42032621c13a@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

This is tagged, pull request will be delayed due to kvm forum though.

On Fri, Jun 09, 2023 at 04:32:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> ping.
> 
> On 22.05.23 23:17, Vladimir Sementsov-Ogievskiy wrote:
> > v4:
> > preparation patches are already merged to master
> > 01: fix false-positive "error: ‘size’ may be used uninitialized",
> >      keep r-bs
> > 
> > Vladimir Sementsov-Ogievskiy (1):
> >    pci: ROM preallocation for incoming migration
> > 
> >   hw/pci/pci.c | 79 ++++++++++++++++++++++++++++++----------------------
> >   1 file changed, 46 insertions(+), 33 deletions(-)
> > 
> 
> -- 
> Best regards,
> Vladimir


