Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABD8167D0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 09:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8XX-00035a-5f; Mon, 18 Dec 2023 02:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8XS-00034e-N3
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:59:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8XR-0007k8-6k
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:59:46 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d3b81d9719so1972455ad.2
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702886383; x=1703491183;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pZ2y68uFhYg6GIRxy2xbsRrto6o/nzarZQX+b4vK17E=;
 b=mzz5C8uLkNyjyxsZLEKMfIxx2AMcBGybWyom0HvVw7/+I0y65VYdSDPcQ7K1eYLlfC
 BbvXqVWJy/D5Y+iJGYaOe0YDhwrqobuXVAOPPDTL4tXS+Wq1TZbZhPhGGvonLgpZmnzJ
 mWFITccbR4TOTNEixQ4Rn38EadM8Qz+wQyDK0DBpPZEqxTtfbgqkXK0iw7QOJHbzOZec
 tV/Ex3vrB1CjRf7OrcpzWZd+uzl/m/WXPX26n4QK7X0TY+YmE2gh4SWUPb4rPsoP8Mry
 dUgnbzcqYzMMA2RTCq4Onm44j61MCVPzTyexK3YyggaFUG1Ab6QfvMjeiJd7tqarMq8b
 +wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702886383; x=1703491183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pZ2y68uFhYg6GIRxy2xbsRrto6o/nzarZQX+b4vK17E=;
 b=M7WB0lBhSyWEUG4pOYcn5KjzI45LKRqouiMVMKbjxAEUKGtAvV+FTk0uBtL9Q4S6Au
 3nsEavCRglYAmd5ndDlCb4Hm+g89FRnUf262y1WiJVFxF85HxiCpS065o9klzNE3r4qH
 FNsVBeZ4vShPr0+4ZHSs31HixwPwYcDPZJeHoSSp9ZXZyCx67yt7yzE2a2ZWRt8PaTMp
 rq7azKbJb2DCXXmQTmekDQavC+celEzbZPR5JnxuJpWliSl7P0IKSRXKv/3yaKoSoJJH
 JrIeWJPBfWm0/XviHEYgtlMKj+LhBX8yq5gCjcX+QpzVU8u/swtjkbf1NBLrqUZ7A+c3
 7V0A==
X-Gm-Message-State: AOJu0Ywa9NVREOt+VmsRLQAZBllXwcZQOW7/14hOWtDGQmhRO0WQFUkc
 D73ASts35kdv85YOuG2no844dA==
X-Google-Smtp-Source: AGHT+IFSOlGBvwbNcmspHfdtxsUAA8GxcJVPWyzSGZfoXBL62JqJtybOtXhJTV5Dv3mQVR5sIRo4xA==
X-Received: by 2002:a17:902:e80f:b0:1d3:a9e2:b7b with SMTP id
 u15-20020a170902e80f00b001d3a9e20b7bmr471541plg.16.1702886383640; 
 Sun, 17 Dec 2023 23:59:43 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001cfd35ec1d7sm3958461plz.243.2023.12.17.23.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:59:43 -0800 (PST)
Message-ID: <d73b8c8e-fde3-49e6-88b8-8f9bfa248509@daynix.com>
Date: Mon, 18 Dec 2023 16:59:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
Content-Language: en-US
To: Rene Engel <ReneEngel80@emailn.de>
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, smarkusg@gmail.com, qemu-devel@nongnu.org
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/17 18:46, Rene Engel wrote:
> 
> --- Ursprüngliche Nachricht ---
> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
> Datum: 17.12.2023 07:25:52
> An: Peter Maydell <peter.maydell@linaro.org>,  Philippe Mathieu-Daudé <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Marc-André Lureau <marcandre.lureau@redhat.com>,  Marek Glogowski <smarkusg@gmail.com>
> Betreff: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
> 
> Tested-by: Rene Engel <ReneEngel80@emailn.de>
> 
> This patch now works with the "option zoom-to-fit=on/off" thank you very much.
> 
> But there is severe mouse lag within Cocoa output in full screen. You can reproduce the problem by using the mouse very slowly inside the machine where the mouse pointer no longer moves (guest). This issue only occurs with Cocoa edition SDL/GTK works without mouse lag within the machine.

I can't reproduce the issue. Is it a regression caused by this change or 
an existing bug?

