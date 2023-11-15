Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F27EBC6D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 04:55:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r36xv-0008KZ-Ol; Tue, 14 Nov 2023 22:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r36xu-0008KQ-EA
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 22:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r36xs-0007MJ-Lq
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 22:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700020399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLsBshritBkNiOuYVYOhLB4LOlnqTjzm/Dp3F+beaHg=;
 b=XcsUYD+Vkj8bB5IJlOkWkDz1Wwb0DZqEkfB+zqF/xnWt9AVYr1gS7SeY3RwR38N4lnrx+x
 tl1EVGZqyBrlqzHndvTUTvaV1vbTV+y6jffdua5B1ZKBAN/58K6wauUQd8L4kcQjHhkUkU
 aUp6vFBpAt/BDO3o/s1mirEnBkPNxMI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-dz5sqjnuOB2D2v1lEy4xgA-1; Tue, 14 Nov 2023 22:53:17 -0500
X-MC-Unique: dz5sqjnuOB2D2v1lEy4xgA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b2ef9a0756so7509342b6e.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 19:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700020397; x=1700625197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TLsBshritBkNiOuYVYOhLB4LOlnqTjzm/Dp3F+beaHg=;
 b=nB+26+mW+MwsvrGC23DuimDY5fquMGqo3m6UdzxKKwhG6iEgDtJSdomWF8+Sv0QJ0/
 26DCSA6YX9b4ll3gGWLcsnVvS2MBZ4YF2ZlROPX64L4a8A4nqfYnzydGM2G8gTfl2QBO
 IS15AEyTmB5iScbNfsnJAP1VrUId9yFkKixSaEolVVvfjJHQGrEstQbUziRYcRG7g8nM
 OessoQJYTL7/+fCKPUqfTV3Hul6uqMUx9Tr20c66GCbPNA5djq16i4A6Fx8rVCAQthnM
 xS9G09IolXBGGmge+INu+8SKaVp29Zs+Zk0kIs+n5RXh1vTl8ERNsIiLijgz1eONSOq4
 /Y6g==
X-Gm-Message-State: AOJu0YwwJ4IwWgdyvgOItVh3LRo56BxJ94bXWr6CkLtQC6iBtAL3ZsAy
 bg0xYQzhS/odsQCq7eKHOMkSq5xz1xVRjeeMUdRxWacdAEWmlF+wzjq1Y3AsrwRA4JG5UQtOvtK
 LSOms54MyCvBT5xQ=
X-Received: by 2002:a05:6808:493:b0:3a6:fb16:c782 with SMTP id
 z19-20020a056808049300b003a6fb16c782mr13816275oid.30.1700020396854; 
 Tue, 14 Nov 2023 19:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsiKsF/BeKYAn2++MnOy4hL4Sna3JIfVTzbswPzes7MDTICgDYq7AB1LW1xw/uxG6BlvgpVQ==
X-Received: by 2002:a05:6808:493:b0:3a6:fb16:c782 with SMTP id
 z19-20020a056808049300b003a6fb16c782mr13816234oid.30.1700020396558; 
 Tue, 14 Nov 2023 19:53:16 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 x14-20020aa784ce000000b006b97d5cbb7csm1950057pfn.60.2023.11.14.19.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 19:53:15 -0800 (PST)
Message-ID: <6c5eccd4-0261-4633-a5d7-bb880220df94@redhat.com>
Date: Wed, 15 Nov 2023 13:53:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-9-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231113201236.30668-9-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/14/23 06:12, Salil Mehta wrote:
> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
> and non-hotplug events like system power down event. Each of these can be
> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
> the CPU hotplug event.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <Gshan@redhat.com>


