Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B611B7EAB03
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 08:44:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2o51-0007P3-Ff; Tue, 14 Nov 2023 02:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2o4l-0007Jc-EL
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:43:11 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2o4j-0003mf-Tl
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:43:11 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so10691081a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 23:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699947785; x=1700552585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGJSh7ARTE57eUspw2fZ/Y9FEN8W9w9Q7cghnGFYjQE=;
 b=kp4QYm0Yqe8jneVzF41+8k+pHEwH9SKcRdlGvPk/RUXGWT9pfFUs62+A2VrNct/DvI
 aDUtuG7o8TvGdQmHb/0cqcIkchajPmSF2xH7G7PiyA6+M2zz8FuZVmgDmFcyP+a0os1r
 UtiC3axfmgIWWfA+BZbrO7aEhThlMvhWnFvNKQH06u/cfnPBAy1RwzQ0i1b5OOqMRQ5D
 LeQYPngqYahfvj2Bgmd4GTtzMJosJs5VmmN23TnOliQgHDauW5+tcoA9dJkOMUiS5ZrH
 XT9wrnHKrhfGZ/kaO9mpkVnOx4iAmp2K6r3z5mgt8KTb3RZec7HLP8XTUPIiRplKbDs2
 njbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699947785; x=1700552585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iGJSh7ARTE57eUspw2fZ/Y9FEN8W9w9Q7cghnGFYjQE=;
 b=a6jpu4AiR9rAE1C5gqcJIDPtBjdZ2NYFl3qqUDHnZkU1B3slM9sdGdQFKxC0ICUR5G
 6OSI+cuvRNNZN46F3jxbbzG5i0GHuWHMda0aW9SUCc/ln/HjnfqGcMXSeUvcuip/OGpm
 BEkLkzNjeBH4fNcY/fAnMTu9rmQgR8BrUZTF73AOtJKqM4+08DM824GNI8au51dHf10z
 Mahg5afUfx9oPCPnh6XuLWSmAuUUlkH0XuC4wNac327O4HiVibX8+G1J0qqYSuBYCC9N
 sG/xdSQBbCGmYE9WxkW9dCj9RBRTCdEEau7gk6XxT6nz2/dwBkDNRQOmhO+4+R7KV3XH
 /0ew==
X-Gm-Message-State: AOJu0YyYEqVGCuWFOP/8Aql9bybzC56rAq6CwfbGESeqJcKQ/ReC7LbK
 J2AyTcsVw4Em1lEfnl9lHuETGw==
X-Google-Smtp-Source: AGHT+IGc3/NG8UqFInjKsnJ47x00sT9L6VqttZpc9DaeBplNVfbIFLh/QxmAKcqUI5QOxgCuVcfEEA==
X-Received: by 2002:aa7:da07:0:b0:542:ff1b:6c7a with SMTP id
 r7-20020aa7da07000000b00542ff1b6c7amr1704591eds.9.1699947784705; 
 Mon, 13 Nov 2023 23:43:04 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 er22-20020a056402449600b0054130b1bc77sm4739041edb.51.2023.11.13.23.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 23:43:04 -0800 (PST)
Message-ID: <987f44c2-0fff-471f-b69a-fac0da5794df@linaro.org>
Date: Tue, 14 Nov 2023 08:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 08/10] system/physmem: Only include 'hw/xen/xen.h'
 when Xen is available
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-9-philmd@linaro.org>
 <1681041d88a9f9062170eb6599947e24424bf37f.camel@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1681041d88a9f9062170eb6599947e24424bf37f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/11/23 21:03, David Woodhouse wrote:
> On Mon, 2023-11-13 at 16:21 +0100, Philippe Mathieu-Daudé wrote:
>> "hw/xen/xen.h" contains declarations for Xen hardware. There is
>> no point including it when Xen is not available.
> 
> ... if even when Xen *is* available, AFAICT. Can you just remove the
> inclusion of hw/xen/xen.h entirely? I think that still builds, at least
> for x86.

Yep, also on aarch64, thanks!

>>   When Xen is not
>> available, we have enough with declarations of "sysemu/xen.h".
> 
> ... and system/xen-mapcache.h
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


