Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642B7DE26A
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:33:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyCGl-0003JQ-Ll; Wed, 01 Nov 2023 10:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyCGj-0003IH-5S
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyCGh-0001yC-Nl
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698849146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCdhzb6Oe1+xQ6qXsKLFwLlQ1p2CP2lcBL6Kuupzrlw=;
 b=V+ogodnFDb8t+XJCHR/0WPMnpb7WQ6qi/WPH+rPrKJFs+HdBqiiPeEHPxnhQyAIk7342FK
 t8Vu5ogBU7u0DvkRXzFKWi9FpeworJfST+iadwMRl4l5plXXZ6YWqPHUUXywyokow8OTLe
 uXe4rId5aghqMj0LJH6MsSkKmCMKKnU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ci7itM_1PaGQIta3dnfbZw-1; Wed, 01 Nov 2023 10:32:23 -0400
X-MC-Unique: ci7itM_1PaGQIta3dnfbZw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso470308666b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698849142; x=1699453942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCdhzb6Oe1+xQ6qXsKLFwLlQ1p2CP2lcBL6Kuupzrlw=;
 b=bqz/yMcBmdgPJbAHiM5eao/vfwW23/9MObSKOLliWBzhmDAqWnAPBbk87rItVn/UJi
 Yb+fhWi4PUrw4FfYo5ei9nENk16MBIQRtKj9RCq3rQ3Q4n3Ap92cy/EAVGe5YyOLhSEM
 89z3q5ehXkste/Sa4qZxFG0hQ2H5CqFpA/Zxuoz8SZiiIFD9/L8Fnx9YJIWep8x3Z94i
 wGtvOgokjEtN/mMFg+IS5sMnj0UxBtxKJRNYsLTVl56ZvRZPuaPLhbTIHl8Lw+6EZJgQ
 5YIFL4RG4Z5gzJCpGj0Sfbxd8R7WV5+pmS4KJB14BBmOhpuxb9XHRfx8pWnHNPWfxfkG
 AbtQ==
X-Gm-Message-State: AOJu0YwYOJAb2k5D/hhctq77mj9mU0yu3MMAzxJrap7Wso/E9xVLvHIM
 p0lyW/8BVB4BOHAvg75Buqon5wfY0siqwkV9YqunUfJ1/x7fDVJ5CFWNYASeidp/SD/ENkeYpcR
 h8cuU7JU8A6N49rs=
X-Received: by 2002:a17:907:a0a:b0:9bf:9c58:e91e with SMTP id
 bb10-20020a1709070a0a00b009bf9c58e91emr1767701ejc.56.1698849142174; 
 Wed, 01 Nov 2023 07:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7a8O5uHtYGwz5RtUULekujnvBR/L9JmuCDdKk8eZnPKoMp/HvBZ+aAG/wlOg6klDQxjoDeg==
X-Received: by 2002:a17:907:a0a:b0:9bf:9c58:e91e with SMTP id
 bb10-20020a1709070a0a00b009bf9c58e91emr1767694ejc.56.1698849141919; 
 Wed, 01 Nov 2023 07:32:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 i22-20020a508716000000b0053ff311f388sm1163329edb.23.2023.11.01.07.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 07:32:21 -0700 (PDT)
Message-ID: <e688ba46-08b8-4115-a39f-37a019c393fa@redhat.com>
Date: Wed, 1 Nov 2023 15:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tools: build qemu-vmsr-helper
Content-Language: en-US
To: Anthony Harivel <aharivel@redhat.com>, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, berrange@redhat.com
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-3-aharivel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231031144605.64822-3-aharivel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On 10/31/23 15:46, Anthony Harivel wrote:
> +
> +static uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id)
> +{
> +    int fd;
> +    uint64_t data;
> +
> +    char path[MAX_PATH_LEN];
> +    snprintf(path, MAX_PATH_LEN, "/dev/cpu/%u/msr", cpu_id);

If you allow any CPU here, the thread id is really unused.  You can 
however call sched_getaffinity(), and check that the CPU id is included 
in the thread's affinity.  sched_getaffinity() does not need any extra 
capability.

Paolo


