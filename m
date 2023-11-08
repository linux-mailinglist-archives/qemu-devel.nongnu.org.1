Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF247E52F9
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:02:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fOB-0006os-QF; Wed, 08 Nov 2023 05:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fO1-0006oU-VG
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:02:13 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fNz-0003RW-FU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:02:13 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40839807e82so3541635e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699437729; x=1700042529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6xwdW594d+4NwU/s1lRJ6HFZG7RhHAbKxhK8MCU53Ag=;
 b=rgwlz7OcTKHxom/4QwcibbXhtTP2GrhECgytlmJx8aGti6U+EL+1CkH09BifZDenSc
 b9/MU3D7U4eja1cdFqtWEkNlvtbm1Qonw5zDWl10tlj5UZjnNAAvgPXHnFTzJYT2+inp
 Pnlz6DdbfqhBjiXz/P0SFqNT8lCwLF6dzn/r8XOu+XGfFM61kSOGpFMRP3rur3mrYgva
 tDh6jPKpiKFVV/8PkW/fDhIoJ7lWoRD/i89opjMQqhZ3+YNZklGIfc24yIdq7kdpq9x9
 rqVZ/yUM0xvSRaebmkSuK1LCSjnV+Qq4oqs52jHeDfg2+hS/0olgpLOFxm9swjTGGVh1
 m4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699437729; x=1700042529;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xwdW594d+4NwU/s1lRJ6HFZG7RhHAbKxhK8MCU53Ag=;
 b=qv9i1RwB4q22VxxGfWlv4rOFWYWOuSpw++K77Tevc+2vAdnf1Do+fxnSWmh16WcRHU
 y1PLOyw3uW/lDoPVpIjPoMvNveopqJ4syatJqVZbdITb2LazV+vLs+Dcumefk/5sdWCu
 ZTwxuRB4bVw2BvfV6oC1WZoXVTuCUtBHj7re083h6Sd7KQxLQxYjMUocFMfbLodBIfQ1
 vEFITUTG9esy5hszkssvStBOAsGdLvr0LYcAi0YTWHIMyy9T9WfTCpBPzVI36+FmDSrb
 OFc6ovvfw4qpnVhKfqR3/3deI0xgcRhcOOgCSnpY0rRbMZjz7mEuk2mW1DnrVdU0cdJV
 5nWA==
X-Gm-Message-State: AOJu0Yy0dB2nPF2Yp1brYHwJ+2OAEQhzeUSlluslqW5NGfL2RJM8DSnJ
 rE4nH8t6dSydoSQnTeHmZed5LQ==
X-Google-Smtp-Source: AGHT+IHrzNnmBGffHYAhdU61QQWc4qc8UEaI6QY51DSg8B7jORG4EJbMIFSH+fxeKYL5pO2TCU9gkg==
X-Received: by 2002:a05:600c:3306:b0:405:3f06:d2ef with SMTP id
 q6-20020a05600c330600b004053f06d2efmr6281349wmp.4.1699437728695; 
 Wed, 08 Nov 2023 02:02:08 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 iv12-20020a05600c548c00b0040641a9d49bsm18804514wmb.17.2023.11.08.02.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:02:08 -0800 (PST)
Message-ID: <1b3f57dd-7a3f-4630-b1e1-298578bbc5b7@linaro.org>
Date: Wed, 8 Nov 2023 11:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix Windows 2000 and XP HDAudio Support
Content-Language: en-US
To: Christopher Lentocha <christopherericlentocha@gmail.com>,
 qemu-devel@nongnu.org
References: <737e8de1-9c14-453e-35eb-bff1e6b34a4a@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <737e8de1-9c14-453e-35eb-bff1e6b34a4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Thanks Christopher for your patch,

I'm Cc'ing Volker and Gerd who know better this hardware model.

On 7/11/23 20:27, Christopher Lentocha wrote:
> 
> Change the ID to be a Realtek ALC885 so that both
> Windows 2000 and up (including XP) and macOS
> (on a later patch for HDEF ACPI Fixes) support HDA
> HDA is supported for ALC885 on macOS AppleHDA.kext
> and 2K people can use the following file to get
> sound working (MD5sum):
> 
> 959c6ad895ee22d0003fe24b6ce1b150
> 
> WDM_R269.exe
> 
> for Vista+, the following can be used for EQ or if
> the native one doesn't work OOTB (MD5sum):
> 
> fb0aaffcfc620b70b7f3c3b1381d08e5
> 
> Vista_Win7_Win8_R270.exe
> 
> A Note for the Vista+ Driver: You need to go to
> playback settings, under the Speaker, Advanced,
> change the Hz to one that is valid, so sound
> actually plays, though you may need to enable
> under the Enhancements tab, check Disable All
> then change the Hz, and uncheck Disable All
> Under Enhancements, applying after each of
> the tasks, due to a bug in the stock Realtek
> Driver, also note, newer drivers don't work at
> all, even on real machines, this is the latest
> confirmed to work at the moment!
> 
> Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
> ---
>   hw/audio/hda-codec-common.h | 66 +++++++++++++++++--------------------
>   hw/audio/hda-codec.c        |  8 +++--
>   2 files changed, 36 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/audio/hda-codec-common.h b/hw/audio/hda-codec-common.h
> index b4fdb51e8b..ef57a1b98d 100644
> --- a/hw/audio/hda-codec-common.h
> +++ b/hw/audio/hda-codec-common.h
> @@ -24,19 +24,15 @@
>    * HDA codec descriptions
>    */
>   
> +#define QEMU_HDA_ID 0x10EC0885
> +
>   #ifdef HDA_MIXER
> -#define QEMU_HDA_ID_OUTPUT  ((QEMU_HDA_ID_VENDOR << 16) | 0x12)
> -#define QEMU_HDA_ID_DUPLEX  ((QEMU_HDA_ID_VENDOR << 16) | 0x22)
> -#define QEMU_HDA_ID_MICRO   ((QEMU_HDA_ID_VENDOR << 16) | 0x32)
>   #define QEMU_HDA_AMP_CAPS                                               \
>       (AC_AMPCAP_MUTE |                                                   \
>        (QEMU_HDA_AMP_STEPS << AC_AMPCAP_OFFSET_SHIFT)    |                \
>        (QEMU_HDA_AMP_STEPS << AC_AMPCAP_NUM_STEPS_SHIFT) |                \
>        (3                  << AC_AMPCAP_STEP_SIZE_SHIFT))
>   #else
> -#define QEMU_HDA_ID_OUTPUT  ((QEMU_HDA_ID_VENDOR << 16) | 0x11)
> -#define QEMU_HDA_ID_DUPLEX  ((QEMU_HDA_ID_VENDOR << 16) | 0x21)
> -#define QEMU_HDA_ID_MICRO   ((QEMU_HDA_ID_VENDOR << 16) | 0x31)
>   #define QEMU_HDA_AMP_CAPS   QEMU_HDA_AMP_NONE
>   #endif
>   
> @@ -137,10 +133,10 @@ static const desc_param glue(common_params_audio_linein_, PARAM)[] = {
>   static const desc_param glue(output_params_root_, PARAM)[] = {
>       {
>           .id  = AC_PAR_VENDOR_ID,
> -        .val = QEMU_HDA_ID_OUTPUT,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_OUTPUT,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_REV_ID,
>           .val = 0x00100101,
> @@ -157,7 +153,7 @@ static const desc_param glue(output_params_audio_func_, PARAM)[] = {
>           .val = AC_GRP_AUDIO_FUNCTION,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_OUTPUT,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_NODE_COUNT,
>           .val = 0x00020002,
> @@ -208,9 +204,9 @@ static const desc_node glue(output_nodes_, PARAM)[] = {
>           .name    = "out",
>           .params  = glue(common_params_audio_lineout_, PARAM),
>           .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
> -        .config  = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
> -                    (AC_JACK_LINE_OUT     << AC_DEFCFG_DEVICE_SHIFT)    |
> -                    (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
> +        .config  = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
> +                    (AC_JACK_SPEAKER     << AC_DEFCFG_DEVICE_SHIFT)    |
> +                    (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>                       (AC_JACK_COLOR_GREEN  << AC_DEFCFG_COLOR_SHIFT)     |
>                       0x10),
>           .pinctl  = AC_PINCTL_OUT_EN,
> @@ -221,7 +217,7 @@ static const desc_node glue(output_nodes_, PARAM)[] = {
>   /* output: codec */
>   static const desc_codec glue(output_, PARAM) = {
>       .name   = "output",
> -    .iid    = QEMU_HDA_ID_OUTPUT,
> +    .iid    = QEMU_HDA_ID,
>       .nodes  = glue(output_nodes_, PARAM),
>       .nnodes = ARRAY_SIZE(glue(output_nodes_, PARAM)),
>   };
> @@ -230,10 +226,10 @@ static const desc_codec glue(output_, PARAM) = {
>   static const desc_param glue(duplex_params_root_, PARAM)[] = {
>       {
>           .id  = AC_PAR_VENDOR_ID,
> -        .val = QEMU_HDA_ID_DUPLEX,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_DUPLEX,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_REV_ID,
>           .val = 0x00100101,
> @@ -250,7 +246,7 @@ static const desc_param glue(duplex_params_audio_func_, PARAM)[] = {
>           .val = AC_GRP_AUDIO_FUNCTION,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_DUPLEX,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_NODE_COUNT,
>           .val = 0x00020004,
> @@ -301,9 +297,9 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>           .name    = "out",
>           .params  = glue(common_params_audio_lineout_, PARAM),
>           .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
> -        .config  = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
> -                    (AC_JACK_LINE_OUT     << AC_DEFCFG_DEVICE_SHIFT)    |
> -                    (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
> +        .config  = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
> +                    (AC_JACK_SPEAKER     << AC_DEFCFG_DEVICE_SHIFT)    |
> +                    (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>                       (AC_JACK_COLOR_GREEN  << AC_DEFCFG_COLOR_SHIFT)     |
>                       0x10),
>           .pinctl  = AC_PINCTL_OUT_EN,
> @@ -320,10 +316,10 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>           .name    = "in",
>           .params  = glue(common_params_audio_linein_, PARAM),
>           .nparams = ARRAY_SIZE(glue(common_params_audio_linein_, PARAM)),
> -        .config  = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
> -                    (AC_JACK_LINE_IN      << AC_DEFCFG_DEVICE_SHIFT)    |
> -                    (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
> -                    (AC_JACK_COLOR_RED    << AC_DEFCFG_COLOR_SHIFT)     |
> +        .config  = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
> +                    (AC_JACK_MIC_IN      << AC_DEFCFG_DEVICE_SHIFT)    |
> +                    (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
> +                    (AC_JACK_COLOR_PINK    << AC_DEFCFG_COLOR_SHIFT)     |
>                       0x20),
>           .pinctl  = AC_PINCTL_IN_EN,
>       }
> @@ -332,7 +328,7 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>   /* duplex: codec */
>   static const desc_codec glue(duplex_, PARAM) = {
>       .name   = "duplex",
> -    .iid    = QEMU_HDA_ID_DUPLEX,
> +    .iid    = QEMU_HDA_ID,
>       .nodes  = glue(duplex_nodes_, PARAM),
>       .nnodes = ARRAY_SIZE(glue(duplex_nodes_, PARAM)),
>   };
> @@ -341,10 +337,10 @@ static const desc_codec glue(duplex_, PARAM) = {
>   static const desc_param glue(micro_params_root_, PARAM)[] = {
>       {
>           .id  = AC_PAR_VENDOR_ID,
> -        .val = QEMU_HDA_ID_MICRO,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_MICRO,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_REV_ID,
>           .val = 0x00100101,
> @@ -361,7 +357,7 @@ static const desc_param glue(micro_params_audio_func_, PARAM)[] = {
>           .val = AC_GRP_AUDIO_FUNCTION,
>       },{
>           .id  = AC_PAR_SUBSYSTEM_ID,
> -        .val = QEMU_HDA_ID_MICRO,
> +        .val = QEMU_HDA_ID,
>       },{
>           .id  = AC_PAR_NODE_COUNT,
>           .val = 0x00020004,
> @@ -412,9 +408,9 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>           .name    = "out",
>           .params  = glue(common_params_audio_lineout_, PARAM),
>           .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
> -        .config  = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
> +        .config  = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>                       (AC_JACK_SPEAKER      << AC_DEFCFG_DEVICE_SHIFT)    |
> -                    (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
> +                    (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>                       (AC_JACK_COLOR_GREEN  << AC_DEFCFG_COLOR_SHIFT)     |
>                       0x10),
>           .pinctl  = AC_PINCTL_OUT_EN,
> @@ -431,10 +427,10 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>           .name    = "in",
>           .params  = glue(common_params_audio_linein_, PARAM),
>           .nparams = ARRAY_SIZE(glue(common_params_audio_linein_, PARAM)),
> -        .config  = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
> +        .config  = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>                       (AC_JACK_MIC_IN       << AC_DEFCFG_DEVICE_SHIFT)    |
> -                    (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
> -                    (AC_JACK_COLOR_RED    << AC_DEFCFG_COLOR_SHIFT)     |
> +                    (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
> +                    (AC_JACK_COLOR_PINK    << AC_DEFCFG_COLOR_SHIFT)     |
>                       0x20),
>           .pinctl  = AC_PINCTL_IN_EN,
>       }
> @@ -443,14 +439,12 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>   /* micro: codec */
>   static const desc_codec glue(micro_, PARAM) = {
>       .name   = "micro",
> -    .iid    = QEMU_HDA_ID_MICRO,
> +    .iid    = QEMU_HDA_ID,
>       .nodes  = glue(micro_nodes_, PARAM),
>       .nnodes = ARRAY_SIZE(glue(micro_nodes_, PARAM)),
>   };
>   
>   #undef PARAM
>   #undef HDA_MIXER
> -#undef QEMU_HDA_ID_OUTPUT
> -#undef QEMU_HDA_ID_DUPLEX
> -#undef QEMU_HDA_ID_MICRO
> +#undef QEMU_HDA_ID
>   #undef QEMU_HDA_AMP_CAPS
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index b9ad1f4c39..6999869c70 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -117,7 +117,6 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
>   
>   /* some defines */
>   
> -#define QEMU_HDA_ID_VENDOR  0x1af4
>   #define QEMU_HDA_PCM_FORMATS (AC_SUPPCM_BITS_16 |       \
>                                 0x1fc /* 16 -> 96 kHz */)
>   #define QEMU_HDA_AMP_NONE    (0)
> @@ -514,7 +513,7 @@ static void hda_audio_command(HDACodecDevice *hda, uint32_t nid, uint32_t data)
>   
>       node = hda_codec_find_node(a->desc, nid);
>       if (node == NULL) {
> -        goto fail;
> +        goto alcnode;
>       }
>       dprint(a, 2, "%s: nid %d (%s), verb 0x%x, payload 0x%x\n",
>              __func__, nid, node->name, verb, payload);
> @@ -652,6 +651,11 @@ fail:
>       dprint(a, 1, "%s: not handled: nid %d (%s), verb 0x%x, payload 0x%x\n",
>              __func__, nid, node ? node->name : "?", verb, payload);
>       hda_codec_response(hda, true, 0);
> +
> +alcnode:
> +    dprint(a, 1, "%s: not handled: nid %d (%s), verb 0x%x, payload 0x%x\n",
> +           __func__, nid, node ? node->name : "?", verb, payload);
> +    hda_codec_response(hda, true, 0x0885);
>   }
>   
>   static void hda_audio_stream(HDACodecDevice *hda, uint32_t stnr, bool running, bool output)


