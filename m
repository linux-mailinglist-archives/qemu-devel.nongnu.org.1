Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9EF7446EA
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFU6B-0002dh-Nf; Sat, 01 Jul 2023 02:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFU69-0002dI-3c
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:28:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFU66-0004B7-U0
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:28:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so3317363f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688192921; x=1690784921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XHAeWuvwbInnyDvoFeHtnsBxEwlbXX8RBv2pA/viWVM=;
 b=wF6j3GM+iZem5M9DHlAXkf3CamWqRgpiZw5/SRdEM2bETne/oUJCFQx679w7g0SJi4
 sRaBIivbinC1rE5Bs5hjTIDTt5+K71sbmIYh+O6IMaEaUEVEFh2QWbd6vlEEPTql7/JQ
 LfkdYRwlR2PXPAn8Ac2MUXyu+SrLSBHGuXzSw2tV75/mMx6/vajHO/7gPVibooBe+9PC
 qAdd2nK8vinitAhHcE7gLkDdgfzp6ISjkd6S7+qamwKHZbw3T4OgBUqq66FTozhwTasx
 HMEUFW7c5KNUVVBuKEDv6RE1WiFiUQlblkuWW1Eh9UPm1VLHcRQW753bKBaqEK4z/nAX
 2twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688192921; x=1690784921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XHAeWuvwbInnyDvoFeHtnsBxEwlbXX8RBv2pA/viWVM=;
 b=jSGiqV4yB3BUlZ4u81dPBxCkMLjJhHVTHN8hx6M+4krZddgFx5DwwAtckMHOvbpP3+
 kkVmPKQokuTFVg5Q+SJznr5GMzEH+gXG//IH/eI4xtof1x0KtAvoI9VBWz7W0aqOEQGA
 E1vDxn6i+zPhhGPoX7zV2NXkzSCPdmCN6YdtjcpkQxhYa/WC1XlSqcrcNcGT897PLQTZ
 DozmB3eC1cDJig9PVlLPBAyXq49luUp8rwrlzEitCVyWXl1oalYqtr0zwAZfHqd3jqHM
 YSOFGR0sSty5eHb4A+r7AKAf8t40qRe3ItemcLFGJviTKchmStfLrvVpnHkm+YV0pbXx
 nC3g==
X-Gm-Message-State: ABy/qLZRjoljPSSEaAZ5xPBGEj6/YZb+4EuhqZwwxffe99AAAlN54CGY
 AEDlf+OZXDzu7/AYVRwQOWUERw==
X-Google-Smtp-Source: APBJJlHw3L6DeHysP7ztFSXtbd36UmFihsP4M5dycT8+UOn2GAiuWXkEurPjPt98dzoNZMEl/anYBQ==
X-Received: by 2002:a5d:550d:0:b0:311:1a9c:5e03 with SMTP id
 b13-20020a5d550d000000b003111a9c5e03mr4796856wrv.51.1688192920785; 
 Fri, 30 Jun 2023 23:28:40 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 u18-20020adfeb52000000b003113943bb66sm20041472wrn.110.2023.06.30.23.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 23:28:40 -0700 (PDT)
Message-ID: <efd6705a-893d-7c6d-c3eb-264928b055b3@linaro.org>
Date: Sat, 1 Jul 2023 08:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] audio: dbus requires pixman
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230630214156.2181558-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630214156.2181558-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/30/23 23:41, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> Commit commit 6cc5a615 ("ui/dbus: win32 support") has broken audio/dbus
> compilation when pixman is not included.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1739
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   audio/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued to tcg-next, per request.


r~

