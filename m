Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4477F984A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TCn-000350-K9; Sun, 26 Nov 2023 23:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TCl-00034Q-Pe
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TCk-000847-FJ
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=PB3rrbDhFhAYGJu1tpDRetEJdZ4RPIsc2foTm4wermkzhGFhv28rcQ+pkcLhc5FfQMPOs8
 CqP2SgElbzfFRyVr3x+t3QJzMiLKPZulmibAbKLwr3e3hx3tkvLVVaeRN9qejPFhZqwvYQ
 uAC1kqYpmpygcG50ppHxzZiWfQ7qW+E=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ILnqKvuaMoK9VdgDlrPIcg-1; Sun, 26 Nov 2023 23:26:39 -0500
X-MC-Unique: ILnqKvuaMoK9VdgDlrPIcg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6cb9dd2ab9cso3858205b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059199; x=1701663999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=osiHEKRw/wWXulwrmB6ekv4M1RSXdNVKay92y87LESJEC6D0kVK8YQXgNv7Wv1TYCh
 uVlhDj/S5SE1V95kFgV2UTwero2Mi4Jwh+9eGx1lohR2VYQ/ZX7IS2XWgdSy4G7J6lfR
 HQNQgV2rpaPXtgo2QMp3dNxV0HRMcmfaBAXGFccg6jFBOZM1OM++OcxoxOHRfDf/js5L
 7pPEDrqiJ2ZumFSmODpleJKHGhhuLcqz0mNaK8w9zqzrW7IsImchiFU4OIIdmkv6FJu5
 cfajCLAkFeP1jOLXlWESzrFRrVJjxorAzlwtKUHXid55qUwJrZLlB7B9Dohw0L0Hwe7J
 +1kQ==
X-Gm-Message-State: AOJu0YzOvBpgq0CqHRSuTBW1mA4DcdjtQHxcPzLKB1BRRCOE27ULid++
 h0BCBh3OM4TPRmGnXLC1JxJzmVlGFDKGqOdg6cU2MBcB6JdBRt6PGyuxT16L+VuqX68VVdPCdcs
 biKgRxll7G21te2w=
X-Received: by 2002:aa7:9a87:0:b0:6bb:8982:411c with SMTP id
 x7-20020aa79a87000000b006bb8982411cmr9200722pfi.8.1701059198889; 
 Sun, 26 Nov 2023 20:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlQgLBRj9RDgY8/fOQHANXpbPnRJoIpEX3kwfRAw85G15nRnOlWbfc823/LeAaCBRyIjGsDQ==
X-Received: by 2002:aa7:9a87:0:b0:6bb:8982:411c with SMTP id
 x7-20020aa79a87000000b006bb8982411cmr9200711pfi.8.1701059198624; 
 Sun, 26 Nov 2023 20:26:38 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 m22-20020aa78a16000000b00692cb1224casm6337813pfa.183.2023.11.26.20.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:26:38 -0800 (PST)
Message-ID: <a803c70b-319b-4b32-b0f5-fbe5723d33fe@redhat.com>
Date: Mon, 27 Nov 2023 15:26:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 11/16] target/arm/kvm: Have kvm_arm_vcpu_finalize
 take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-12-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


