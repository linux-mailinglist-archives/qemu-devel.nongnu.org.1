Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3467B5DFB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 02:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnT0I-0001yu-0R; Mon, 02 Oct 2023 20:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnT0F-0001yD-Nj
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnT0E-0008UK-9Z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696291865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9moNmM+DaQ6xrnDbiLNN/vIK+QYde3QGFbF7hxRLbOc=;
 b=IdfrABsfTwDfA+XT6eVh3SOlFeGoFM+frgKe77R5dwByBzRJeAL6hd1E3kFa3FMvL92mGF
 ZUOYEnNrTB890BeakIegYnZnwPlJD9HYDKBExEz/sf6mm+Cmgga3Eq/NAT3M0+4QOwBgL/
 mnNJeFs3/E1FU5cFCdBxpYtOh4/6P7I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-Xp1mMc_ePjiqSZQ5rgGs7g-1; Mon, 02 Oct 2023 20:10:52 -0400
X-MC-Unique: Xp1mMc_ePjiqSZQ5rgGs7g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c0e161e18fso27965255ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 17:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696291851; x=1696896651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9moNmM+DaQ6xrnDbiLNN/vIK+QYde3QGFbF7hxRLbOc=;
 b=e/yVqFA/wtfdfoyjOj/XwK3VcYVZZ6WNNA8d8lBUlBAwVn4jg9RQQzmZOGyGGqQFkQ
 T4RGUiK2GHSuBhfsw8P9juAGYxO8OcUOgtNHnEYLwqOuKsxbwDnzd5TPd43DxVIW6B1h
 8G5KcKvi5QcOY2T5K77phkgOJcKHOpzbt2bU01azHu8VmM/JKNEGRHPDTydsc6BV0Hl1
 97TQcncmTomXTGgk3FckpP3Ae5c4rtbISOAcDoxR6kcaJcBt1y9ci9lcunEoIjb+Qn9m
 vqsuEgxcyjCKJKyGQ87qrYBeofp3ZbnKN/2+B5nMwBjMuBdrP09Va3GQlEYiLnHgnMZr
 skUw==
X-Gm-Message-State: AOJu0Yz4C3mOC4E+Xuz3Nu+U25wR+cUmmmTjs220aLKAH1rLg+xVS1C2
 CCM/kDBw4tHO2zFPU1M40b6sJl1DcdU4KoU8NOHlnIUeD7YejwJQB5jN8rrl/1LqVnRc2WE8f2n
 DKuRUJso7dFF4J74=
X-Received: by 2002:a17:903:2283:b0:1c0:bcbc:d66 with SMTP id
 b3-20020a170903228300b001c0bcbc0d66mr1975300plh.7.1696291851571; 
 Mon, 02 Oct 2023 17:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzqlw5/j7ueD0f29wlohvNcFaFO1mH75DtY75nD6Km9BR8wuqyZ195DO+LZiKrzAniO313Uw==
X-Received: by 2002:a17:903:2283:b0:1c0:bcbc:d66 with SMTP id
 b3-20020a170903228300b001c0bcbc0d66mr1975268plh.7.1696291851286; 
 Mon, 02 Oct 2023 17:10:51 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170903228900b001b896686c78sm46059plh.66.2023.10.02.17.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 17:10:51 -0700 (PDT)
Message-ID: <810a4999-9954-55f0-9408-b86b36e9e18b@redhat.com>
Date: Tue, 3 Oct 2023 10:10:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 06/10] hw/acpi: Update GED _EVT method AML with cpu scan
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
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-7-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-7-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/30/23 10:19, Salil Mehta wrote:
> OSPM evaluates _EVT method to map the event. The cpu hotplug event eventually
> results in start of the cpu scan. Scan figures out the cpu and the kind of
> event(plug/unplug) and notifies it back to the guest.
> 
> The change in this patch updates the GED AML _EVT method with the call to
> \\_SB.CPUS.CSCN which will do above.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/generic_event_device.c | 4 ++++
>   include/hw/acpi/cpu_hotplug.h  | 2 ++
>   2 files changed, 6 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


