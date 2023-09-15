Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C117A20B4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9fL-000796-LD; Fri, 15 Sep 2023 10:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh9f5-00078Y-AP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:19:11 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh9f2-0000Le-Vv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:19:11 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9aa2c6f0806so282503266b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694787547; x=1695392347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/AcmynaycQWqEDoYblZSWlJBhVKwsCM0fWUiWVAgSJI=;
 b=uUcMaVXet/1GDqoRUXtMAhW8N/s5GNti6bw/hWwYsX2R/St/hz/gChAGjJA09PGRQl
 xkBcWTFc2xjc5fOe8I463YApvNdNI5AsADBowJ9zqazt3KGrtFncv6AI6eW1s/Os+5Gg
 vxG+NPjg/b/egj4NXG7BG3MJplQHyLKDPFoUmY1DHlK1eoDCPhUkCB6AoShZdjHwxUFm
 QGiJPX7gWrHdNQkaFDG8wBkkEGLtPrImtpFjzfMJ6FtpMaQGQBCMmMs49fyljcHo9k6R
 H+PuWAgXDiMDR6m/IrQkkjpYoQTEcE3qwHzimwQsRx+rxoVvPgTKJP1jQLMp04zBrmKj
 FlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694787547; x=1695392347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/AcmynaycQWqEDoYblZSWlJBhVKwsCM0fWUiWVAgSJI=;
 b=NDl8ZP6flACDR25VG/CUbNWYYsbKZKfvLM0H6OWZBe5ZvlvZpqtZCHghtwavvcUfZx
 pJlXqK5d0UYXcUp2TmJE3RGXHamU8DgVKuHITW6n/Pl17oHhP708zWIn/YYt5d0WAhnE
 P9pRPTJaXUgoYaI8jnUkZa5jtXnXtLmOCXUcG2f4xTwpSSXY5wtRicWQntJFkaRSyuvx
 UQr8iRgNq8sULxBqFRf4JYOJDIJDNc34S/siDywPgn9zlFWTyswjIjfSzOkRC6nJHSBe
 Kz8Dkz3TSO2kE86y5Y3Iz9ML5OHp3rR/Wlu9DrIv3Vu9ZkBE1SFBG4tsSIdSS7qQ4j3s
 E7zQ==
X-Gm-Message-State: AOJu0YynMD7Q9/JP4PzAr+0kpLEi1PXwCzGKiXkiW8iuRn3m3q+Z8nZh
 MCX2p+TBiKEXK+FiYX0wfP/mQw==
X-Google-Smtp-Source: AGHT+IFxtF+ocN+CUR3zPzm5dC15nw+4CzgG3gcttN25KYcwf4b3exkq8n3SBd1cK/gHun7lPd1U7A==
X-Received: by 2002:a17:906:5308:b0:9a1:d087:e0c0 with SMTP id
 h8-20020a170906530800b009a1d087e0c0mr1610848ejo.42.1694787546938; 
 Fri, 15 Sep 2023 07:19:06 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a170906165300b009ad75d318ffsm2524330ejd.17.2023.09.15.07.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 07:19:06 -0700 (PDT)
Message-ID: <cd28d7e5-cf77-dce0-756d-d6f75657727d@linaro.org>
Date: Fri, 15 Sep 2023 16:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, lixianglai
 <lixianglai@loongson.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/9/23 10:07, David Hildenbrand wrote:

> The CPU implementation end up call qemu_init_vcpu() in their realize 
> function; there should be something like qemu_destroy_vcpu() on the 
> unrealize path that takes care of undoing any cpu_address_space_init().
> 
> We seem to have cpu_common_unrealizefn()->cpu_exec_unrealizefn() but 
> that doesn't take care of address spaces.
> 
> Also, in qemu_init_vcpu() we do a cpus_accel->create_vcpu_thread(cpu). 
> I'm, curious if we destroy that thread somehow.

Implicitly in cpu_remove_sync().

