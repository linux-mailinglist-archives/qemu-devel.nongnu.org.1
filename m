Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BE7B60EE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZ8h-0004QT-Vi; Tue, 03 Oct 2023 02:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZ8g-0004Q6-1I
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:44:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZ8e-0004oO-HI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:44:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso559261f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696315450; x=1696920250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+EjhnXyPxXga8N7Mi0khWKDMpK6Bb5LUXVYPpUwv0kE=;
 b=yoZw3Dz0FXGdy0Sjf3naFJRWfjAAZG8GVrIRVZb20f7//+O2qH5VKLOiPpc+zbvgZe
 QV/hb6BW+eBwQ2MUR9l3olc78q0uy5YsObwsvEuzLA8yt/VEC8CHyJRchl9MFxZYiHle
 xWHhzS6SMyA92zq8K1lR7Uo2l3VfXukXHLfvEHh67llfY3vK+Q5RSQ2yXijShYnDPg76
 YxcxfX/g9fwtjUWRazRvN9QB3lyUYuTkpyix5Ihi0octcXaIrwTMzveCVi3JPRWSFRpe
 wm2UdGHq2BnVVptwYafSVk+R5z0uYnQUqyHUOQXduVp2mMq0q9qP7fOylw+lxpTJfxnH
 Y8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315450; x=1696920250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EjhnXyPxXga8N7Mi0khWKDMpK6Bb5LUXVYPpUwv0kE=;
 b=Td8DS+4jUIFj+uKPen0yUgH9jWY0bH+yWrdayFWo9dmI7sRN5lMQ/wyVlgbFRYoMX4
 vDnQv7MYDApg0rC3JiWOGvyZIo7eLXK/TpVhk1uHvqEzDtX5PPQaUG3AkQhy5Z7jpIRk
 tSwNXol/0qt9Zab3JKd6Br/uRD5lx9TMB4mM04rWK4jAe3Afu8xpEWE9O4inHoI/vbOD
 WgQTbTLAHu+nz0MKvHBRPqJjfoCMRGPL5h1KrCqkyUyMyqzqpqCnIp213ZNJpNkXcMqZ
 fpJlljsU+Lpmsi+X+kZcUtgusRzU1P/gVAsE2tTyfrSa6WbYFHUNIw6IHPbW4DEM3hs7
 MPQw==
X-Gm-Message-State: AOJu0Yw/O0pgdfRoqIwUNa/cEQzEDbhqff8+pemVa1P4ynxpNib2MdB9
 umsyfmYu80UuBti6yxZJNjOBwgEm7lj4zU13vMN3Zw==
X-Google-Smtp-Source: AGHT+IH1f/kx2g8O0aHlJoykwsu2/99BV5h17gx2MRNLbRv0pyCR+ijDL5C58vORZxDL12K9gE85Hg==
X-Received: by 2002:a5d:66ca:0:b0:317:e542:80a8 with SMTP id
 k10-20020a5d66ca000000b00317e54280a8mr11351827wrw.15.1696315450321; 
 Mon, 02 Oct 2023 23:44:10 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 f16-20020adff590000000b0032326908972sm785806wro.17.2023.10.02.23.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 23:44:09 -0700 (PDT)
Message-ID: <87e1be19-c1c6-73fb-3569-7dbf186662f7@linaro.org>
Date: Tue, 3 Oct 2023 08:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915190009.68404-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 15/9/23 21:00, Philippe Mathieu-Daudé wrote:
> - Add missing accel_cpu_unrealize()
> - Add AccelClass::[un]realize_cpu handlers
> - Use tcg_exec_[un]realizefn as AccelClass handlers
> 
> Philippe Mathieu-Daudé (5):
>    accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
>    accel: Introduce accel_cpu_unrealize() stub
>    accel: Declare AccelClass::[un]realize_cpu() handlers
>    accel/tcg: Have tcg_exec_realizefn() return a boolean
>    accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG

Ping?


