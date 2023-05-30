Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F1716185
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:21:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zGh-0002WS-Lx; Tue, 30 May 2023 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3zG9-0002DW-8w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3zG7-00075W-Dp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685452770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ynm0xO5MUan+kAinVWSc2/SnD9ILI51RCGZ1BB6iaZ4=;
 b=VNPVRcbi18KiMd/hlcHoUiLnCk+/QWfBlhwmYol9T0M/A2dQ5Wb9GN4vhEZa0sLlv3Nhdl
 5f7Yllegm2F3f+11Shl2cQHVFGL5s/DKBpT/S4+7XlMN3xmrbqj1rPwYxDuGzM1FZGQV55
 yfNY1IHU4niJO4RqJ2/421RrkR+44TI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-GnYgHgARP8WlgeGg05Tnvw-1; Tue, 30 May 2023 09:19:28 -0400
X-MC-Unique: GnYgHgARP8WlgeGg05Tnvw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30af222c5feso647411f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452767; x=1688044767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ynm0xO5MUan+kAinVWSc2/SnD9ILI51RCGZ1BB6iaZ4=;
 b=bVExm26fYlAxu8n6hc3+WSb2Jdxm/3J70SSwudo6xonrw75izCjE6lZhT/8liM675/
 8t28mOTo+gLwMPfeTi18Zh3Idq6LrssEF7jbts2rpxHbqUiuLs/LPKBJW1yME2ZMLxCa
 grbpVBROzOqjHVEAXeP5xvLxLIwUbnyYgWNnokOqwTWwbB4CnyONL55XVCi0g+AvSrEG
 QfGBmjlDb3cv6lTFv/4pP3dALeRx1IfkoAKzZ/3BaS+sQWfadk7Bmz8uP9mceYBr2Zmu
 bqRcXKib02AgDEYifRe4H9FSe5lNSv50LyK6fLGRdeHVGUHT003iCGbNY0AzrLisV1sN
 QB4g==
X-Gm-Message-State: AC+VfDwJinyrGRq6WYLFBwUHI9sw8FA4p6RZE3VrcHjJZYU8dHXYvCiL
 hDmv8yqR539xs/w1v67beqg+ZDEDOnpyIhOAbx1nKjdgmPDvipZ5gqxEPmW5EQuxkwUOXhSINFN
 lOZ6yYsQ/KTngnUM=
X-Received: by 2002:adf:fe88:0:b0:30a:e499:e5ff with SMTP id
 l8-20020adffe88000000b0030ae499e5ffmr1890262wrr.30.1685452767586; 
 Tue, 30 May 2023 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qaGWHNCB7BLMEkACoBvQOQOlMyiboC1X3+WiNapKDFRa0zmvQuvj4tDku3Sql3eKM7METTQ==
X-Received: by 2002:adf:fe88:0:b0:30a:e499:e5ff with SMTP id
 l8-20020adffe88000000b0030ae499e5ffmr1890253wrr.30.1685452767340; 
 Tue, 30 May 2023 06:19:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a5d4b82000000b0030aec5e020fsm3252687wrt.86.2023.05.30.06.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:19:26 -0700 (PDT)
Message-ID: <40005787-04e6-c4a0-20d4-ddb14d6de0b2@redhat.com>
Date: Tue, 30 May 2023 15:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 1/4] linux-headers: Update for vfio capability
 reporting AtomicOps
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-2-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230526231558.1660396-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 5/27/23 01:15, Alex Williamson wrote:
> This is a partial linux-headers update for illustrative and testing
> purposes only, NOT FOR COMMIT.

Are you planing such an update for v6.5 ?

Thanks,

C.

> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   linux-headers/linux/vfio.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4a534edbdcba..443a8851e156 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -240,6 +240,20 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
>   
> +/*
> + * The following VFIO_DEVICE_INFO capability reports support for PCIe AtomicOp
> + * completion to the root bus with supported widths provided via flags.
> + */
> +#define VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP	5
> +struct vfio_device_info_cap_pci_atomic_comp {
> +	struct vfio_info_cap_header header;
> +	__u32 flags;
> +#define VFIO_PCI_ATOMIC_COMP32	(1 << 0)
> +#define VFIO_PCI_ATOMIC_COMP64	(1 << 1)
> +#define VFIO_PCI_ATOMIC_COMP128	(1 << 2)
> +	__u32 reserved;
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
>    *				       struct vfio_region_info)


