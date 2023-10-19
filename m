Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0457CFBB3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTRS-0003WH-0H; Thu, 19 Oct 2023 09:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTR9-0003Kv-Tx
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTR8-0003pg-7v
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697723500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WT758E5/3Zc2NyFoIrIc/bVq2NyqZ85qvSn6rFHfMU=;
 b=ab8HlGL0LyMQOG1Of1KQ5zRq40yuchy/wliwVw1zSHWd54ococlP1cSDYzdpTm9YobJBBq
 I2biF2Uw0WBe4kdf5CveCLKIFUSxrFFdT/vsbSpU5uCXDnDcbQYKl5qlr5VMGb9VL3ZrlE
 caPsYPpc36yin+Py5MFBrQuamPuUVkg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-5QGfGfe1O8ShR4N8ey590A-1; Thu, 19 Oct 2023 09:51:38 -0400
X-MC-Unique: 5QGfGfe1O8ShR4N8ey590A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77892f2ee51so250793685a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723498; x=1698328298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2WT758E5/3Zc2NyFoIrIc/bVq2NyqZ85qvSn6rFHfMU=;
 b=JjGSekBEcvKr19HpdAnSHvjOQjG5soA24EQpG7IMS5vre29cuH8TOfdpyNuR6dRjYY
 V8bLTk4DRSWghvHbU7hiP7CP4Mw04wwZuKhFR3IHkWL0RyyQSfnftKbbkJvJ1L73h+40
 GrMdSztX0s4W6vMljxppP/+3ithE5OkTGiO8t1q4RJOAFGf7fda2wZDejaLhcscaFkeF
 73DCXErVsG2nj9/E0Z+wyjvyeLFWEiMsN7BFoHdSTCCQvBmmSi/8VApgdWBzImX6sHn0
 xFGFMn3hWeMgA68WqyOPMCuyn5X2wKl9N5zbdocZvOcgwTN4eOZsdD0BD1zmmIlgpO/D
 Y02Q==
X-Gm-Message-State: AOJu0Yw9BHeiHoWPz5TMCfWSncv9VW7mFbaDQMlYZByrt97PRqHDMtaT
 MOoxdAJcnn220Yno2vcaW+hBRhs9XVvcIhYujhsFumkpSiJR5Cq+Dd+h7RlSPYJmXTW3gtA/VGL
 0MuqzBF2jBpUSoDc=
X-Received: by 2002:a05:620a:8295:b0:778:91f0:e541 with SMTP id
 ox21-20020a05620a829500b0077891f0e541mr1836182qkn.23.1697723498113; 
 Thu, 19 Oct 2023 06:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQjpUWBwRFp1RLztiby5LvEkEMTfXReKE+/WLOWOW03CuuRaOyPdkAmAYQe4Ltd2nsgYbZjg==
X-Received: by 2002:a05:620a:8295:b0:778:91f0:e541 with SMTP id
 ox21-20020a05620a829500b0077891f0e541mr1836161qkn.23.1697723497868; 
 Thu, 19 Oct 2023 06:51:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a05620a140600b00767d8e12ce3sm761408qkj.49.2023.10.19.06.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 06:51:36 -0700 (PDT)
Message-ID: <9a8912df-23d1-64c0-134d-cc42838b34d8@redhat.com>
Date: Thu, 19 Oct 2023 15:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 YangHang Liu <yanghliu@redhat.com>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231018093723-mutt-send-email-mst@kernel.org>
 <9ddc3f2e-8be7-4e03-bf9f-3ac930650a52@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9ddc3f2e-8be7-4e03-bf9f-3ac930650a52@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 10/19/23 13:07, Cédric Le Goater wrote:
> On 10/18/23 15:37, Michael S. Tsirkin wrote:
>> On Wed, Oct 11, 2023 at 07:52:16PM +0200, Eric Auger wrote:
>>> This applies on top of vfio-next:
>>> https://github.com/legoater/qemu/, vfio-next branch
>>
>> virtio things make sense
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> let me know how you want to merge all this.
>
> Michael,
>
> I will grab the series if that's OK.

I have just sent a v4 taking into account Alex' suggestions, collecting
Michael's and Alex' R-b, and YangHang's T-b.
This should be ready to go if you don't have any other comments and if
this survives your non regression tests ;-)

Eric
>
> Thanks,
>
> C.
>


