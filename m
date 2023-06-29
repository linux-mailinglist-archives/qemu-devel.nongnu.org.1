Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B239742130
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmGs-0000gv-KT; Thu, 29 Jun 2023 03:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmGq-0000gi-Bn
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:40:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmGo-0005Is-NX
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:40:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313f59cd193so395625f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688024449; x=1690616449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJSSyuNBpO1yNtYrF0pIDvR1ch6+R+2Bgf+En3WFJpM=;
 b=gbTpIH6XjoiMEZcXlwHg9jfoIl7ZGmd57bcE+z4dhZSHQUWEd9zRz4IBUU3aKMOvdL
 +QTDJt9Si/4EIH1/uwX1NApgfx/tdPpkL2t5qlQB4vvgHPqL17lppfukScM77zgflaLd
 5StrSF/7sph58DLJ27COlTDgemwB52AvEnyDuAhT0bpY6YhNhwbeiohOJoE8T37yKIZV
 PtdP1J6tYQ8FNX0j4iMOZ68Csb1vND9QegNHrIXKc7bAJFzO8tVXdWGEfAdmehuNJzET
 eaKf1LqYgzQ698zCvmfVu8GNHVDLPrd0JXmuOgkbgttPgD8T/nuLpBdFxy9r/fepxLXD
 nSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024449; x=1690616449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJSSyuNBpO1yNtYrF0pIDvR1ch6+R+2Bgf+En3WFJpM=;
 b=dWq7Ph37bZjwNmBnHQ6Ntf8ZH1hgQb0mfP8mvktK0p5nYbIHdRhtwC7AwFi0E7YK8R
 EvC9ycUaZxExSbIxynXKL9wsx9a8iOxABP3UwS6gs31Ux9gYb3XEvX2pGLmC4RBXtkL9
 GwI+QCgEJIPVWgQUoFmyllzJf6yN6dQPVtKQDMAmPSFVtsfVCbY0/Bszg8QS59igeDKc
 ct5UMgib3PHvl7PSiWNrFEEKDcNZdWLMboYBoC9voWMmNv6zrnNmhUFDoQS+Hx9LhKE/
 UrfpqBnT+d03sSaOi/V4VTlntfjdioeYzgmeWGz6ecRc3QrMt3CRi2rGf2Lt2VGZJn9J
 J7Qg==
X-Gm-Message-State: ABy/qLbuQ13CnSp6ev6EA9p/ZqL1Wc2i1Nfq8U01jurPtqvC0UIrhOoD
 qhzlLNs5p75GWL2f+SHkJBkkWA==
X-Google-Smtp-Source: APBJJlGVaR8c14/5pVRvK9O0yjQ1XFNi2fuNo35nVHJc2CNovjW2aQIrK1OAMkySzuypEiL9pYawxA==
X-Received: by 2002:adf:f210:0:b0:314:105f:df5f with SMTP id
 p16-20020adff210000000b00314105fdf5fmr2725374wro.22.1688024449151; 
 Thu, 29 Jun 2023 00:40:49 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm9683066wrm.103.2023.06.29.00.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:40:48 -0700 (PDT)
Message-ID: <8d3e6b12-80d1-8900-3b1f-115be40f1fb1@linaro.org>
Date: Thu, 29 Jun 2023 09:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 33/33] ui/dbus: use shared D3D11 Texture2D when possible
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-34-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627130231.1614896-34-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/27/23 15:02, marcandre.lureau@redhat.com wrote:
>   static void dbus_update_gl_cb(GObject *source_object,
> -                           GAsyncResult *res,
> -                           gpointer user_data)
> +                              GAsyncResult *res,
> +                              gpointer user_data)
>   {
>       g_autoptr(GError) err = NULL;
>       DBusDisplayListener *ddl = user_data;
> +    bool success;
> +
> +#ifdef CONFIG_GBM
> +    success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
> +        ddl->proxy, res, &err);
> +#endif
> +
> +#ifdef WIN32
> +    success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
> +        ddl->d3d11_proxy, res, &err);
> +    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
> +#endif
>   
> -    if (!qemu_dbus_display1_listener_call_update_dmabuf_finish(ddl->proxy,
> -                                                               res, &err)) {
> +    if (!success) {
>           error_report("Failed to call update: %s", err->message);
>       }

With neither CONFIG_GBM nor WIN32, success is not set:

../alt/ui/dbus-listener.c:199:10: error: variable 'success' is uninitialized when used 
here [-Werror,-Wuninitialized]
     if (!success) {
          ^~~~~~~


r~

