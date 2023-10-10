Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC97BF820
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9W7-0003at-B0; Tue, 10 Oct 2023 05:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9W5-0003ab-LW
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9W4-0005Yl-7D
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696931943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFDoNYvu4AGyjhzaDodqA+59Tdxx5F8lL1P2nMkx30I=;
 b=Gf/Wc0wEWaoiOi0B7SufsZkMKEYAA7G/gD9VBLG+vtOrQUT/rs+5LpxeJihDQpO5EX08Vp
 yS+MfgOXgyGx74TYEfTq2EatRlfP3hsdexg9HiaFcFMpIiKOu+j013B646Hw4Wtt9G/eFP
 a8LhpCH0lnQpTx5fwqyXYmh1gR8EfRY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-TpKk44v7PqmmcLTIGbFM7g-1; Tue, 10 Oct 2023 05:58:52 -0400
X-MC-Unique: TpKk44v7PqmmcLTIGbFM7g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-418ce89e56cso65230321cf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696931932; x=1697536732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFDoNYvu4AGyjhzaDodqA+59Tdxx5F8lL1P2nMkx30I=;
 b=d3KsLk05EjohQbKE1xU8QfpzHtn4CEM/Bt+AceG69lR25SsXKplrciEJRSvtniv01U
 3oep7QDVWP5W4ZxdWQTjFEqBcyR4hjNnR87ty1AjkcgNrnyPMnFpZtVldcPoVK3/l3CE
 TlvQ9UyRfIlDumuJa6DcJAx4m3XPtkFnjPseXyEYwYFzKATDad/f+8Q05mvXGTWBfpeD
 5R4e9h+sit5wcVWBViTcMoMNM6oB9jIGhg8SjZbIRLHVH7VUoKbADnHxpMc/ulQ+jCYc
 vrMLWLlKpnC0yEUlPe3hm0qVfmVDmCNh2xfPNum3LNk8rUtWHcW8rwNuXp4WEIV79Mx8
 /arg==
X-Gm-Message-State: AOJu0YznimIPurGstR5dlME17Ij7fD6UMPj1MArRsIgtiS0AKEVVfcoZ
 bbQPXfj09GYj6RMFg//9IOhSaaYr96EWSfVhcO0zqImKsoZidHuP8h+ySQuANwliiQ5G57XoDYm
 n/zAu0nCQ48kQZiQ=
X-Received: by 2002:a05:622a:144d:b0:40d:6219:d813 with SMTP id
 v13-20020a05622a144d00b0040d6219d813mr22774605qtx.68.1696931932088; 
 Tue, 10 Oct 2023 02:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbBUn9gES2H6HOHDCRusb2C5SDVShiUyzMuf3QwjoQvNjIDng1sueAteMEYrsVfuWCo9k+pg==
X-Received: by 2002:a05:622a:144d:b0:40d:6219:d813 with SMTP id
 v13-20020a05622a144d00b0040d6219d813mr22774595qtx.68.1696931931846; 
 Tue, 10 Oct 2023 02:58:51 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 bb36-20020a05622a1b2400b00403ad6ec2e8sm4352278qtb.26.2023.10.10.02.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:58:51 -0700 (PDT)
Message-ID: <a3ff5135-2fd1-b3dd-f576-129ef08b47be@redhat.com>
Date: Tue, 10 Oct 2023 11:58:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] tests/qtest: Use qtest_get_base_arch()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231010074952.79165-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/2023 09.49, Philippe Mathieu-Daudé wrote:
> Additionally use qtest_get_arch_bits() when relevant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/ahci-test.c           |  5 ++---
>   tests/qtest/am53c974-test.c       |  4 +---
>   tests/qtest/bios-tables-test.c    |  6 +++---
>   tests/qtest/boot-sector.c         |  6 +++---
>   tests/qtest/device-plug-test.c    |  6 ++----
>   tests/qtest/drive_del-test.c      | 16 ++++++----------
>   tests/qtest/erst-test.c           |  4 +---
>   tests/qtest/fuzz-e1000e-test.c    |  4 +---
>   tests/qtest/ivshmem-test.c        |  6 +++---
>   tests/qtest/libqos/qos_external.c |  6 ++++--
>   tests/qtest/lpc-ich9-test.c       |  4 +---
>   tests/qtest/m48t59-test.c         |  6 ++----
>   tests/qtest/pxe-test.c            |  6 +++---
>   tests/qtest/qos-test.c            |  6 ++++--
>   tests/qtest/readconfig-test.c     |  6 +-----
>   tests/qtest/rtas-test.c           |  4 +---
>   tests/qtest/ufs-test.c            |  4 +---
>   tests/qtest/usb-hcd-uhci-test.c   |  6 +++---
>   tests/qtest/virtio-net-test.c     |  3 +--
>   tests/qtest/virtio-rng-test.c     |  4 +---
>   20 files changed, 44 insertions(+), 68 deletions(-)
> 
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index eea8b5f77b..93d1e14896 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1835,7 +1835,7 @@ static void create_ahci_io_test(enum IOMode type, enum AddrMode addr,
>   
>   int main(int argc, char **argv)
>   {
> -    const char *arch, *base;
> +    const char *base;
>       int ret;
>       int fd;
>       int c;
> @@ -1867,8 +1867,7 @@ int main(int argc, char **argv)
>       }
>   
>       /* Check architecture */
> -    arch = qtest_get_arch();
> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> +    if (strcmp(qtest_get_base_arch(), "x86")) {
>           g_test_message("Skipping test for non-x86");
>           return 0;
>       }

While this change makes sense (unifying two checks into one) ...

> diff --git a/tests/qtest/am53c974-test.c b/tests/qtest/am53c974-test.c
> index ed3ac7db20..dc41182a38 100644
> --- a/tests/qtest/am53c974-test.c
> +++ b/tests/qtest/am53c974-test.c
> @@ -253,11 +253,9 @@ static void test_reset_before_transfer_ok(void)
>   
>   int main(int argc, char **argv)
>   {
> -    const char *arch = qtest_get_arch();
> -
>       g_test_init(&argc, &argv, NULL);
>   
> -    if (strcmp(arch, "i386") == 0) {
> +    if (!strcmp(qtest_get_base_arch(), "x86") && qtest_get_arch_bits() == 32) {

... this change looks more cumbersome now (doing two checks now instead of 
one), at least at the current point in time. Do you urgently need this for 
your refactoring? If not, I'd maybe postpone such changes that make the 
checks more compilcated to a later point in time.

  Thomas



