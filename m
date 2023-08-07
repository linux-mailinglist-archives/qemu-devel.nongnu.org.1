Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A364A773539
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 01:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT9yo-0004tf-VC; Mon, 07 Aug 2023 19:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9yl-0004tU-A3
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 19:49:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9yj-0002f0-NY
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 19:49:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686b879f605so3526508b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691452176; x=1692056976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wI0OQ+MUPqcQraLFVyiJpiTY7wlXDnIaxf/M1VqQU/g=;
 b=S2bX7M+Bo44HBlrYdmLF7WxO6Nr3NK2sQa0cED3It559lMX9DaK1RIDyrd5ZZwV8aq
 q+k2OEWa8AOxb5wPSkvIPoZCWte5Pl1KqFY+F0vsyD1gM0jyub2gHkRaVOxqydnQxOt5
 Q4AopEJ3NEkxNv5D70luDdLyWcY3ybPjuZPvQ7i9ojPa9TXtsay4LO+RqwpmPtj06uJT
 5jrpj5HoSB5T+S2oRAgwS7JruyXdpLFx/HC8+22FPFTLGJ136tzT3onV3rH4n9vqvgnm
 PWCkcRCKLHRDU6dvmaOFQ/RdS4ExUz/M8yo+tFpnyp9RosyQM/F6KNG30CgqhPbJCtWK
 BX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691452176; x=1692056976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wI0OQ+MUPqcQraLFVyiJpiTY7wlXDnIaxf/M1VqQU/g=;
 b=j3xsd9UUsKxfIk/uSm9CrozxA7Bq17lGekp4fl7nJUsYq0sXPOu662ynCYhqFjuJi7
 Q5wBLhdjGrxH/1IgB0llN1iuz/PkcJNPAlJthH60SY8h8z/hj6H0SAx8o6+p0vDuBaNu
 qstZQzQbq1DZwbwMWhJAlRgEP8oZZZSx0FNvF1hUiM/5G//LwE6VlCWv4xncOemTG1xc
 Wbt3yjzFQpsBebFXFc439MdfvGMoIRFkERM2GLJnNN4mLUNIzk7NJjGyOEchlhfh0eW5
 Oir7pZRvQoqmdTTQAMrnhdcRXr1ORG/3CbpaI9sHKbGYoxr4ClOInYXZ/cOuWqwzDx72
 wnJQ==
X-Gm-Message-State: AOJu0YylRb8MpKawXiMQoKmmfYYiLqn0mXd4EqlrYPuI37RCVB/uNEM8
 HwOmyw0Ypx0F8vpBLfrOSCvNsQ==
X-Google-Smtp-Source: AGHT+IEZOTlSjwXuXnJ+ZH6bFujI3O6nxlEZ+GiUYx9JqyQGoJNOESR2iuteaHl0FxgB0Iq953R6Mg==
X-Received: by 2002:a05:6a20:3950:b0:133:712e:f700 with SMTP id
 r16-20020a056a20395000b00133712ef700mr11022492pzg.51.1691452176274; 
 Mon, 07 Aug 2023 16:49:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902e5cd00b001ac95be5081sm7447727plf.307.2023.08.07.16.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 16:49:35 -0700 (PDT)
Message-ID: <c108bb65-b8f8-bbee-4281-9b116326ad89@linaro.org>
Date: Mon, 7 Aug 2023 16:49:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/6] Fixes patches
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 13:47, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:
> 
>    Merge tag 'pull-tcg-20230806-3' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-08-06 16:47:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git  tags/fixes-pull-request
> 
> for you to fetch changes up to 58ea90f8032912b41e753a95089ba764fcc6446a:
> 
>    ui/gtk: set scanout mode in gd_egl/gd_gl_area_scanout_texture (2023-08-07 17:13:42 +0400)
> 
> ----------------------------------------------------------------
> Fixes for 8.1
> 
> Hi,
> 
> Here is a collection of ui, dump and chardev fixes that are worth for 8.1.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


