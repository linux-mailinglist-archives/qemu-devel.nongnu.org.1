Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9BA830B6F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ93j-0005OP-9q; Wed, 17 Jan 2024 11:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rQ93g-0005HI-Gq
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rQ93e-0001Ps-Bx
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705509983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cd3Ose77j/HJBnKN6w+dtcgDO0iKk1wmfevfCIa9z2M=;
 b=DfFKjkKXWAnNV5uSMbZBuh4yIVfx8nfQDEYZflf1bdtdn8HJezZt+50ClNWQiJ9C1c7rts
 n5xRJzMTfbBlr938AFbhTWtqTUkADe5JsKNr4BEGmUdWFJqmbSG/PoOEo9a4qicGm4k8nq
 GxVES5+OHrrmd/9fnHYegIk5AqWDAGQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yacjbNI1OVmEMSLM7h_gZw-1; Wed, 17 Jan 2024 11:46:21 -0500
X-MC-Unique: yacjbNI1OVmEMSLM7h_gZw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42793cd9d33so145440781cf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705509981; x=1706114781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cd3Ose77j/HJBnKN6w+dtcgDO0iKk1wmfevfCIa9z2M=;
 b=MUBsxolNVDIYpglVUkDmuqNirdLQdoCyIzX9qieQyBU/cR0mMKjboGrqyltqBwumIw
 oJUFQsD9W0PcOU2ire3QqminzLy9dZvWamOb5eTnIq2jSpOIsXNV7r7dSNywqjtV6OLe
 e/Q4SnFEt/oDNLXZJomTBwTopmSZUtiBq6c9XS3hHsXvYalsVT+6F6XfHaoU1tJixpmJ
 ExuU0jmVYOngAJyv9J6yDQ4weC18eObMCdScCtmhBuwDSCZV9Q80KebaOShM3blWD56Q
 +gBT2ewMNQwvqA39jDBWV0MvThgGdqPXkTrYrOjpyz9Ssy9EuZdPmh/w9LwqrMQR5j5i
 LOdw==
X-Gm-Message-State: AOJu0YwStKVo0Tqtp3jCm6AdbS8NfLTbNvA0gbBBZJAyz+sRQHfSwvsN
 fdUyjywR0vO9/8G0VmCco+sGHJk8rINYe8oFe8Ro4vP/QBFwaMs5MINc9uaeuIktyvnTJBxMjJC
 E13Nw6mMGJU2Jck8+kzyTL3A=
X-Received: by 2002:ac8:5a8f:0:b0:42a:1553:cff6 with SMTP id
 c15-20020ac85a8f000000b0042a1553cff6mr220651qtc.126.1705509981278; 
 Wed, 17 Jan 2024 08:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW8fkE05FBmJaoynz/aIXVHHUcHQ3Pr6KAGIwSnuZA15bWET+UbtWEv7wkEEnwLU9Ap7PbBw==
X-Received: by 2002:ac8:5a8f:0:b0:42a:1553:cff6 with SMTP id
 c15-20020ac85a8f000000b0042a1553cff6mr220640qtc.126.1705509981068; 
 Wed, 17 Jan 2024 08:46:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bq9-20020a05622a1c0900b00429940c13a8sm5928765qtb.34.2024.01.17.08.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 08:46:20 -0800 (PST)
Message-ID: <00336880-d380-4c64-a0dc-67d7ca6fedbd@redhat.com>
Date: Wed, 17 Jan 2024 17:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240115080144.44944-1-shahuang@redhat.com>
 <852ee2a3-b69f-4480-a6f4-f2b274f5e01c@redhat.com>
 <36a1efb3-2538-c339-d627-843e7d2b6541@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <36a1efb3-2538-c339-d627-843e7d2b6541@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hi Sebastian,

On 1/17/24 17:29, Sebastian Ott wrote:
> On Wed, 17 Jan 2024, Eric Auger wrote:
>> On 1/15/24 09:01, Shaoqin Huang wrote:
>>> +    /*
>>> +     * The filter only needs to be initialized through one vcpu
>>> ioctl and it
>>> +     * will affect all other vcpu in the vm.
>>> +     */
>>> +    if (pmu_filter_init) {
>> I think I commented on that on the v4. Maybe I missed your reply. You
>> sure you don't need to call it for each vcpu?
> 
> From (kernel) commit d7eec2360e3 ("KVM: arm64: Add PMU event filtering
> infrastructure"):
>   Note that although the ioctl is per-vcpu, the map of allowed events is
>   global to the VM (it can be setup from any vcpu until the vcpu PMU is
>   initialized).
Ah OK. I forgot that specificity.

Thanks!

Eric
> 
> Sebastian
> 


