Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDF7420B8
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElgn-0005h1-LN; Thu, 29 Jun 2023 03:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qElgl-0005gp-3x
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qElgj-0001BZ-HI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688022212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9bscQ0IDJt5PHSQ4HzAZSeHwNSqQCf1TER+BZW+DVo=;
 b=VaCHaBq9e8pG0P/HadiCMfVhDH6rgWii3vtB7eApmrFFTjMNSJHidieIz2joQisEtDFUMF
 WM2ISC2xhFXqIXQLqw5W2TkaH5kH+Csygpzn+7IGAel+cfh4q8nE15TNTaEgH8Lw3cq1jV
 9J0tNDlSTUP8y3pHgPhyuGbZh7Mo3Ds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-NOAG_V9aOVOQx-hncFcB1A-1; Thu, 29 Jun 2023 03:03:25 -0400
X-MC-Unique: NOAG_V9aOVOQx-hncFcB1A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f810b4903fso1902275e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688022204; x=1690614204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9bscQ0IDJt5PHSQ4HzAZSeHwNSqQCf1TER+BZW+DVo=;
 b=HSHL92p+AUPb6LbUOzL6ZxblY2vtl0E7qggWmRZZQyyAWBWObltPLxRua4fXkEVQU+
 n3jw665GiwMzi1e6R76QrINqCHw4x4xTiY7GnBU5+qAMea82WHUPmmNW+mnnd8vmq+ti
 u6ibRjIQHIfueregjXKpdJIxQWd++VMqv54bYM7fvqE585F7q0RJBiuAyvEbJ/WoFcoe
 rYJRKU4bSzDdJoNZgw0tqWGEf/rxRfW/3ps2sLuBJU4YtW2n0LQS3kyThyd26XTJFd+R
 ehrPxuP84TlfUN9j6v8ap/8FB2B+ErgBUTiQXZeY3iJTZUEQJS058XV1RyWfC7NrSuu2
 h4jg==
X-Gm-Message-State: AC+VfDyrw9canOFx6gdmg1vWjhgPDw3AAaQcrV/RDznCXOf8jAnJcIJl
 VMmtwX7L3aCGMVdmJ+7Xyueq+NO4ekzw5yCqI8jc8z+Py9/NAUmU8fCDj+H5C9wjsI8OfXCj1+M
 KRQ0tnVd/Cg1Yc3g=
X-Received: by 2002:a1c:7419:0:b0:3f9:b79d:a5fa with SMTP id
 p25-20020a1c7419000000b003f9b79da5famr21471202wmc.16.1688022204345; 
 Thu, 29 Jun 2023 00:03:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ROGRnSzkqRiatRBkgIPmD7GL87XsZq7bJfRttqRXjLCBngPt+oxBoB3FrN4iMB/F5kWmvUA==
X-Received: by 2002:a1c:7419:0:b0:3f9:b79d:a5fa with SMTP id
 p25-20020a1c7419000000b003f9b79da5famr21471194wmc.16.1688022204097; 
 Thu, 29 Jun 2023 00:03:24 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a5d4047000000b003063772a55bsm15134305wrp.61.2023.06.29.00.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:03:23 -0700 (PDT)
Message-ID: <7dd54a5e-ed28-0a5e-9ef0-5d3e8985c1f7@redhat.com>
Date: Thu, 29 Jun 2023 09:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-5-anisinha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230629040707.115656-5-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/06/2023 06.07, Ani Sinha wrote:
> The test attaches a SCSI controller to a non-zero slot and a pcie-to-pci bridge
> on slot 0 on the same pcie-root-port. Since a downstream device can be attached
> to a pcie-root-port only on slot 0, the above test configuration is not allowed.
> Additionally using pcie.0 as id for pcie-to-pci bridge is incorrect as that id
> is reserved only for the root bus.
> 
> In the test scenario, there is no need to attach a pcie-root-port to the
> root complex. A SCSI controller can be attached to a pcie-to-pci bridge
> which can then be directly attached to the root bus (pcie.0).
> 
> Fix the test and simplify it.
> 
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   tests/qtest/hd-geo-test.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)


Acked-by: Thomas Huth <thuth@redhat.com>



