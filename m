Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AB717600
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4E2N-0007te-QF; Wed, 31 May 2023 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4E1k-0007oo-P0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4E1h-0001AI-M0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685509536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcjTIlyEV57eSFFLiw1M6vs6xSF071LDpzjutOgIraM=;
 b=BEgOWUuYvwI67/vAPv3ifol4jAeVCid2WU3D8+9kogTIobpee3cToeEaKlm1yS8SN9qdN7
 g6sfRlSq4oAWxb1QFcLip0pPi1dSwBfgyYtBRdYtXFeJQ6Vpv4+YuZc8m20XjYdkQY5MPX
 +GEBhBscIQEvSc3iM8y6dT1G1ESbQkQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Z0rT-FhnMRWVBcHozL1bRA-1; Wed, 31 May 2023 01:05:27 -0400
X-MC-Unique: Z0rT-FhnMRWVBcHozL1bRA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f6e83685eso554747966b.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685509526; x=1688101526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcjTIlyEV57eSFFLiw1M6vs6xSF071LDpzjutOgIraM=;
 b=Heq9zfByKabDmPpCZTWR88i5j2K144DmVwsKLWUdnZyklixNvvpaCsVrKWUhjB/cH1
 U5gKAiysgx3ak1mBlxzsYW/bVO3/mVc3fcqEsUVDTzp6AzW8nZwpEVebZE1AHY2xumgX
 g4CLiZmX2g2ocFavTgm6/ZhWeJWivy2ft3l9bxc36foJZ+kWEcjlvBuUTtyZ1z/Bx9Sa
 I9aUixV7LDhmbZp2UozEqLMKOKDhutuhcNzVgayt4iHN3SIa+SOSZDRrahuNf/WvZWrU
 XN0bUppm55DxfJUYw9nbYD0omj8cYeiGn07GFjY8/780RGclcMT1XumaeSLJ6c9wRaZW
 vqTA==
X-Gm-Message-State: AC+VfDwlx6n4GvVLmjDZ3otPAz/YfHniNgm5V3hkJyPEtExZJMj95apk
 R7IbxQQUxQUxeGpTkDGgEV4A4hcFywH9/GsOHbSONv98OX3X9HZP3BxBeg6hW18SPJMc0QuMwBA
 mHtGVBRkpPKts5+b/ZuPjUFM=
X-Received: by 2002:a17:907:6ea5:b0:96b:559e:7f2f with SMTP id
 sh37-20020a1709076ea500b0096b559e7f2fmr4891616ejc.38.1685509526320; 
 Tue, 30 May 2023 22:05:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UiYQ/mOy1kv0TJ1V8ySJdnABtB3wzPEgR4cMAJbqBfunw5LoGLBYyT3xUdhOBpc12CHuyxQ==
X-Received: by 2002:a17:907:6ea5:b0:96b:559e:7f2f with SMTP id
 sh37-20020a1709076ea500b0096b559e7f2fmr4891601ejc.38.1685509526019; 
 Tue, 30 May 2023 22:05:26 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 r10-20020a1709063d6a00b009737b8d47b6sm8174430ejf.203.2023.05.30.22.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:05:25 -0700 (PDT)
Message-ID: <af86b279-a0d2-bece-34e8-7429cf9e41d5@redhat.com>
Date: Wed, 31 May 2023 07:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] tests/qtest: enable tests for virtio-scmi
Content-Language: en-US
To: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org
References: <cover.1685476786.git.mzamazal@redhat.com>
 <e20e0b6dae56d520619cbf2883aa4c3004fa06b7.1685476786.git.mzamazal@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <e20e0b6dae56d520619cbf2883aa4c3004fa06b7.1685476786.git.mzamazal@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/05/2023 16.38, Milan Zamazal wrote:
> We don't have a virtio-scmi implementation in QEMU and only support a
> vhost-user backend.  This is very similar to virtio-gpio and we add the same
> set of tests, just passing some vhost-user messages over the control socket.
> 
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> ---
>   MAINTAINERS                      |   1 +
>   tests/qtest/libqos/meson.build   |   1 +
>   tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>   tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>   tests/qtest/vhost-user-test.c    |  44 ++++++++
>   5 files changed, 254 insertions(+)
>   create mode 100644 tests/qtest/libqos/virtio-scmi.c
>   create mode 100644 tests/qtest/libqos/virtio-scmi.h


Acked-by: Thomas Huth <thuth@redhat.com>


