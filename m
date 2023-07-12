Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8017507D2
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYhh-0008OK-7h; Wed, 12 Jul 2023 08:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJYhc-0008Nu-Ms
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJYhR-00009R-QZ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689163924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd//hc3fg7J5dtcfOKOK08NW5nAqs782SmOULsif/Y0=;
 b=h5tI3ctOtdWEEG+Z88DYL3qZMuRhs8nfS3ac1VBYlB6SILK/0hDHIEw2vC7MwY5yixJPFB
 2bbT9dR8d3EDSsvzgdDZLC1dA/r5Bq6qz2j3qGNZ74CILJfQflJVFINqsh086Yas5eOGPu
 TwLA8Sb8db8NEoq3Ip/h+2t1c7yGaZk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-77J2yZhHMCmkHxzXpY4SPw-1; Wed, 12 Jul 2023 08:12:03 -0400
X-MC-Unique: 77J2yZhHMCmkHxzXpY4SPw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb76659d37so6259819e87.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689163919; x=1691755919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd//hc3fg7J5dtcfOKOK08NW5nAqs782SmOULsif/Y0=;
 b=E6quGpQx2DVD9geR92PFQRHzHquxiLKp/KiM03WvB4/zWOrARuW2Rbtpl157URdAO6
 HA9HsHbf8jpEQLrZc1gu6OXjBQ+bgfhZpY9HI0TSsZ0e7zXgNBxeE+fEJemA9GdOPZXF
 wUDLKZtkbrsPd6xanygpZSziTbsb5uoQ7shl2SLfa3jAjT5nhkl9gZqKYXV5tQ++b4w5
 Gor30Xxbl4bCGOw63t0FAhVtQzqICiJUhDaLSh0AwwCqA7Amnsry3un9m08nx7yVye0D
 yosMa4dp/SbVCMRx/kBBQCVlSNxkWUPqXtiA1pD7yGeFPYp1pH5y26atN9qggBfMSvtL
 WiOQ==
X-Gm-Message-State: ABy/qLbtXJ0SFqkJOOLF3ZzOZMHK2CH5vFNQLJ0hIlnqUxZ1BMo7O2DZ
 It4yhXx+SRx5jGply6BMaif7ha4h/RYJLVfnCXlK9FrK5WFUVm2tFadt87fm85cJi5nhmEr6xIv
 ckxlX63jxCcCzra4=
X-Received: by 2002:ac2:5e2f:0:b0:4f7:6017:8fb with SMTP id
 o15-20020ac25e2f000000b004f7601708fbmr13634975lfg.26.1689163919728; 
 Wed, 12 Jul 2023 05:11:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGafDEjWMOIf/g6n5kf3q1Zh+1Iu0qi5z4152Hej2mJpzPSs/vsec9KSS8gQzCTaUsBg0SCyQ==
X-Received: by 2002:ac2:5e2f:0:b0:4f7:6017:8fb with SMTP id
 o15-20020ac25e2f000000b004f7601708fbmr13634958lfg.26.1689163919429; 
 Wed, 12 Jul 2023 05:11:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170906050500b009821ce1ea33sm2506919eja.7.2023.07.12.05.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 05:11:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Date: Wed, 12 Jul 2023 14:11:32 +0200
Message-ID: <20230712121131.130172-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712080146.839113-1-clg@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
> index f2287a133f36..2d5ff476e32a 100644
> --- a/configs/devices/s390x-softmmu/default.mak
> +++ b/configs/devices/s390x-softmmu/default.mak
> @@ -7,6 +7,7 @@
>  #CONFIG_VFIO_CCW=n
>  #CONFIG_VIRTIO_PCI=n
>  #CONFIG_WDT_DIAG288=n
> +#CONFIG_PCIE_DEVICE=n

Should be CONFIG_PCIE_DEVICES; fixed and queued, thanks.

Paolo


