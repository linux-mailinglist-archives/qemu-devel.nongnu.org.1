Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26B715FDD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yXu-0004CQ-D6; Tue, 30 May 2023 08:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yXI-0002s1-C3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:33:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yXF-0001qG-QH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:33:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6dbe3c230so45778015e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449987; x=1688041987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6yEw4Igz3Ifgf3AUYhr+1yF+M1W44Rr9AltMv2QS7lc=;
 b=d3aF0Rs/kmzmCTfDlDMO9LsQtKfiyjMqzEO2a7JJqVxuac0L/iOUtMzN75Xo15irhA
 bWuHEQMajp5jAQHYAhr7VfP/asD7SYPh9V+t2Pcl2zug4iDOg6qdB8prc7eafUzXHEov
 vaDM9PbJJ4pXksVQmkW1WUZTkwVirAkMkd6iuTkQ0BEsGq7u1tyhELBRdZVqpdMjPiu0
 aGQ62CiX/gXSbNrs1dwPK5ZMJouhLdbgRNGHErn8ouJzj5xtOfzqs59nxOwxRQMv15wn
 xgQen3Sjo7YNct/3pB292xL4aPlqhGqSxuVYqmwA1vAMITSitnJ5fW5cqlGaLeNhxCNX
 w29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449987; x=1688041987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6yEw4Igz3Ifgf3AUYhr+1yF+M1W44Rr9AltMv2QS7lc=;
 b=eIYZuVzJCDGALea3GxEWBzxQSBf48hT+qw9jWNHsajDfns2aemOfhXu47ILGsdGVWB
 GFUpSqnbXp2mWTZCqDNFVSziYghwsO2FGVIIsMCj9axKjML4n3L0tVuOxF+GzKghQuDP
 vn6b/sgVLffXiNT5ovTY1kgti2xQmIzWJt++Lma/7TTKFi8QfnEpCW07eP64yz8qcgzD
 ThZaanWzOcbs1OGA1tSC86xjrg0ZPXXCT1gBJyzD1Gh6iIXQh6dghhv/3kTfDKvseqCx
 sj/ixQ5woO3oQG4AAK7ThP8SzRpnUlIOBLkvcf/CpZbK+HbOEGA0R+OP7234OGNWAqUy
 C5AQ==
X-Gm-Message-State: AC+VfDwvFd1Qp+2FUOKpOUt9nwOoefE7zFfnStxxYhDTT9DkTcLVE5so
 pTCBQgyMOH4V1tj2UMNQY8u02A==
X-Google-Smtp-Source: ACHHUZ74mR9NPpRRn18DxXfPAkFkvfyBDNGe+Z5ixr1L6icnr5kkpbSU3RD2MyUs2OQqV6s0ZoHDYQ==
X-Received: by 2002:a05:600c:2242:b0:3f6:a44:73bb with SMTP id
 a2-20020a05600c224200b003f60a4473bbmr2083356wmm.8.1685449987160; 
 Tue, 30 May 2023 05:33:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a7bc3d3000000b003f423508c6bsm16989091wmj.44.2023.05.30.05.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:33:06 -0700 (PDT)
Message-ID: <634c4c3f-c80c-44f1-6d9a-5247061395af@linaro.org>
Date: Tue, 30 May 2023 14:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] hw/i386/pc: Use memory_devices_init()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-7-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 13:38, David Hildenbrand wrote:
> Let's use our new helper and stop always allocating ms->device_memory.
> Once allcoated, we're sure that the size > 0 and that the base was
> initialized.
> 
> Adjust the code in pc_memory_init() to check for machine->device_memory
> instead of pcmc->has_reserved_memory and machine->device_memory->base.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/i386/pc.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


