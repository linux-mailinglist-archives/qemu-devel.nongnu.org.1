Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A47E492D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:28:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RjN-00057P-Qi; Tue, 07 Nov 2023 14:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r0RjL-000579-FI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:27:19 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r0RjJ-0000ci-6g
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:27:19 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a82f176860so72726017b3.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699385236; x=1699990036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w4WEOZjE4TI3O0vqG43CTC3wWCryBTbUTy/6oJ+NBv4=;
 b=jwUtprSLvix1zIEHmgVi12KNBIeSLjpZLbKVSKk8NVRE5V3LLEG6WL0A4+CH/BzRzj
 qWmHpO2lqGvny/ONnRWTZYR86jUzYxmcb4R68pvTDqvlcp/N5KEgF2abBVLzMiNbFDuS
 UVkmeiclIq1F9JV3fqHa6tHnmXm7FsuFJPNXCLTWjqiEF02FRVqE6VoHTfZu+xBe4tJg
 fjF/csjA3JWMBDylp6nfF9K97I2aXw1ALwNbvo4J5q/Tgy5Rx+PxPEKok5WVnsB8ES+l
 NvsioBogICBMJNLXgrF3mvfJTicKdNOjw4yq/UhjCHtTpGNWEXFfeNRpyhh4rSQE340K
 7tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699385236; x=1699990036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4WEOZjE4TI3O0vqG43CTC3wWCryBTbUTy/6oJ+NBv4=;
 b=RWE1HjtUd2Dkh5GuXY9nmEIcbFknGpIT6WiS3KX4y8fpHX88AJFj+/PZfA69Phm0yd
 7p0WpPdgM30wQL2Bd34ohW1Q2qBcTvM3vy/J7v55DLJ7/JhReMRBUTvrgCfuiv3AH37L
 JeMzNwAgazwcRWdzB9Rucr61APh+JlTztxGlkv8CY0yO/ugA3WTj8aYPC2+aR1APABV/
 E7uHk//FwRMs4cni8YNDX2WGOVmmNdjFDu/UIdJgZy3vd3clTl74UriQp2086xx+jcY3
 MSHv5HQg92KoFBLggdKIrgu/IoctjH3EvzxmEZ8lhtEIrSctaff7Aw91JNGZGlv7VtK1
 0S2w==
X-Gm-Message-State: AOJu0YwQUA23XrydR9i0T9Crqf/i+Rm/QI0NQzKhCvguIixn9+OtLVCt
 6VB1BLdHDqd8RTmQcqb7Evc=
X-Google-Smtp-Source: AGHT+IGcL9J+cb6J0Yq7joDpWTVQg2sRxXUy4uu4exgyyj1LveU322KVzyvdFzKsYK22dHklbW7JmA==
X-Received: by 2002:a81:a0ca:0:b0:5a8:3550:61b2 with SMTP id
 x193-20020a81a0ca000000b005a8355061b2mr16340101ywg.29.1699385235596; 
 Tue, 07 Nov 2023 11:27:15 -0800 (PST)
Received: from [192.168.1.4] (172-8-197-221.lightspeed.livnmi.sbcglobal.net.
 [172.8.197.221]) by smtp.gmail.com with ESMTPSA id
 by8-20020a05690c082800b0057d24f8278bsm5810654ywb.104.2023.11.07.11.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 11:27:15 -0800 (PST)
Message-ID: <5bb689a3-eafb-73ab-7941-3e2bb094b261@gmail.com>
Date: Tue, 7 Nov 2023 14:27:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Fix Windows 2000 and XP HDAudio Support
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>
References: <e5b75942-ead6-6955-a484-696dea12b3f1@gmail.com>
 <d753c042-6567-4d4d-9914-626c3220c35d@linaro.org>
From: Christopher Lentocha <christopherericlentocha@gmail.com>
In-Reply-To: <d753c042-6567-4d4d-9914-626c3220c35d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=christopherericlentocha@gmail.com;
 helo=mail-yw1-x112a.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.344, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I forgot to turn off HTML formatting on my mail, 
thats why, sorry.
I also changed the liaf to alcnode if its valid?
Please check your next email from me for the 
hopefully fixed patch!
Thanks,

Christopher Lentocha

On 11/7/23 5:19 AM, Philippe Mathieu-Daudé wrote:
> Hi Christopher,
> 
> On 6/11/23 18:38, Christopher Lentocha wrote:
>>
>> Change the ID to be a Realtek ALC885 so that both
>> Windows 2000 and up (including XP) and macOS
>> (on a later patch for HDEF ACPI Fixes) support HDA
>> HDA is supported for ALC885 on macOS AppleHDA.kext
>> and 2K people can use the following file to get
>> sound working (MD5sum):
>>
>> 959c6ad895ee22d0003fe24b6ce1b150
>>
>> WDM_R269.exe
>>
>> for Vista+, the following can be used for EQ or if
>> the native one doesn't work OOTB (MD5sum):
>>
>> fb0aaffcfc620b70b7f3c3b1381d08e5
>>
>> Vista_Win7_Win8_R270.exe
>>
>> A Note for the Vista+ Driver: You need to go to
>> playback settings, under the Speaker, Advanced,
>> change the Hz to one that is valid, so sound
>> actually plays, though you may need to enable
>> under the Enhancements tab, check Disable All
>> then change the Hz, and uncheck Disable All
>> Under Enhancements, applying after each of
>> the tasks, due to a bug in the stock Realtek
>> Driver, also note, newer drivers don't work at
>> all, even on real machines, this is the latest
>> confirmed to work at the moment!
>>
>> Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
>> ---
>> hw/audio/hda-codec-common.h | 66 +++++++++++++++++--------------------
>> hw/audio/hda-codec.c | 8 +++--
>> 2 files changed, 36 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/audio/hda-codec-common.h b/hw/audio/hda-codec-common.h
>> index b4fdb51e8b..ef57a1b98d 100644
>> --- a/hw/audio/hda-codec-common.h
>> +++ b/hw/audio/hda-codec-common.h
>> @@ -24,19 +24,15 @@
>> * HDA codec descriptions
>> */
>>
>> +#define QEMU_HDA_ID 0x10EC0885
>> +
>> #ifdef HDA_MIXER
>> -#define QEMU_HDA_ID_OUTPUT ((QEMU_HDA_ID_VENDOR << 16) | 0x12)
>> -#define QEMU_HDA_ID_DUPLEX ((QEMU_HDA_ID_VENDOR << 16) | 0x22)
>> -#define QEMU_HDA_ID_MICRO ((QEMU_HDA_ID_VENDOR << 16) | 0x32)
>> #define QEMU_HDA_AMP_CAPS \
>> (AC_AMPCAP_MUTE | \
>> (QEMU_HDA_AMP_STEPS << AC_AMPCAP_OFFSET_SHIFT) | \
>> (QEMU_HDA_AMP_STEPS << AC_AMPCAP_NUM_STEPS_SHIFT) | \
>> (3 << AC_AMPCAP_STEP_SIZE_SHIFT))
>> #else
>> -#define QEMU_HDA_ID_OUTPUT ((QEMU_HDA_ID_VENDOR << 16) | 0x11)
>> -#define QEMU_HDA_ID_DUPLEX ((QEMU_HDA_ID_VENDOR << 16) | 0x21)
>> -#define QEMU_HDA_ID_MICRO ((QEMU_HDA_ID_VENDOR << 16) | 0x31)
>> #define QEMU_HDA_AMP_CAPS QEMU_HDA_AMP_NONE
>> #endif
>>
>> @@ -137,10 +133,10 @@ static const desc_param glue(common_params_audio_linein_, PARAM)[] = {
>> static const desc_param glue(output_params_root_, PARAM)[] = {
>> {
>> .id = AC_PAR_VENDOR_ID,
>> - .val = QEMU_HDA_ID_OUTPUT,
>> + .val = QEMU_HDA_ID,
> 
> Thanks for your patch, but it seems ill-formatted and can't be
> applied :/
> 
> See for help:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches
> 
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_OUTPUT,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_REV_ID,
>> .val = 0x00100101,
>> @@ -157,7 +153,7 @@ static const desc_param glue(output_params_audio_func_, PARAM)[] = {
>> .val = AC_GRP_AUDIO_FUNCTION,
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_OUTPUT,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_NODE_COUNT,
>> .val = 0x00020002,
>> @@ -208,9 +204,9 @@ static const desc_node glue(output_nodes_, PARAM)[] = {
>> .name = "out",
>> .params = glue(common_params_audio_lineout_, PARAM),
>> .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
>> - .config = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
>> - (AC_JACK_LINE_OUT << AC_DEFCFG_DEVICE_SHIFT) |
>> - (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> + .config = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>> + (AC_JACK_SPEAKER << AC_DEFCFG_DEVICE_SHIFT) |
>> + (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> (AC_JACK_COLOR_GREEN << AC_DEFCFG_COLOR_SHIFT) |
>> 0x10),
>> .pinctl = AC_PINCTL_OUT_EN,
>> @@ -221,7 +217,7 @@ static const desc_node glue(output_nodes_, PARAM)[] = {
>> /* output: codec */
>> static const desc_codec glue(output_, PARAM) = {
>> .name = "output",
>> - .iid = QEMU_HDA_ID_OUTPUT,
>> + .iid = QEMU_HDA_ID,
>> .nodes = glue(output_nodes_, PARAM),
>> .nnodes = ARRAY_SIZE(glue(output_nodes_, PARAM)),
>> };
>> @@ -230,10 +226,10 @@ static const desc_codec glue(output_, PARAM) = {
>> static const desc_param glue(duplex_params_root_, PARAM)[] = {
>> {
>> .id = AC_PAR_VENDOR_ID,
>> - .val = QEMU_HDA_ID_DUPLEX,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_DUPLEX,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_REV_ID,
>> .val = 0x00100101,
>> @@ -250,7 +246,7 @@ static const desc_param glue(duplex_params_audio_func_, PARAM)[] = {
>> .val = AC_GRP_AUDIO_FUNCTION,
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_DUPLEX,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_NODE_COUNT,
>> .val = 0x00020004,
>> @@ -301,9 +297,9 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>> .name = "out",
>> .params = glue(common_params_audio_lineout_, PARAM),
>> .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
>> - .config = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
>> - (AC_JACK_LINE_OUT << AC_DEFCFG_DEVICE_SHIFT) |
>> - (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> + .config = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>> + (AC_JACK_SPEAKER << AC_DEFCFG_DEVICE_SHIFT) |
>> + (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> (AC_JACK_COLOR_GREEN << AC_DEFCFG_COLOR_SHIFT) |
>> 0x10),
>> .pinctl = AC_PINCTL_OUT_EN,
>> @@ -320,10 +316,10 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>> .name = "in",
>> .params = glue(common_params_audio_linein_, PARAM),
>> .nparams = ARRAY_SIZE(glue(common_params_audio_linein_, PARAM)),
>> - .config = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
>> - (AC_JACK_LINE_IN << AC_DEFCFG_DEVICE_SHIFT) |
>> - (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> - (AC_JACK_COLOR_RED << AC_DEFCFG_COLOR_SHIFT) |
>> + .config = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>> + (AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT) |
>> + (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> + (AC_JACK_COLOR_PINK << AC_DEFCFG_COLOR_SHIFT) |
>> 0x20),
>> .pinctl = AC_PINCTL_IN_EN,
>> }
>> @@ -332,7 +328,7 @@ static const desc_node glue(duplex_nodes_, PARAM)[] = {
>> /* duplex: codec */
>> static const desc_codec glue(duplex_, PARAM) = {
>> .name = "duplex",
>> - .iid = QEMU_HDA_ID_DUPLEX,
>> + .iid = QEMU_HDA_ID,
>> .nodes = glue(duplex_nodes_, PARAM),
>> .nnodes = ARRAY_SIZE(glue(duplex_nodes_, PARAM)),
>> };
>> @@ -341,10 +337,10 @@ static const desc_codec glue(duplex_, PARAM) = {
>> static const desc_param glue(micro_params_root_, PARAM)[] = {
>> {
>> .id = AC_PAR_VENDOR_ID,
>> - .val = QEMU_HDA_ID_MICRO,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_MICRO,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_REV_ID,
>> .val = 0x00100101,
>> @@ -361,7 +357,7 @@ static const desc_param glue(micro_params_audio_func_, PARAM)[] = {
>> .val = AC_GRP_AUDIO_FUNCTION,
>> },{
>> .id = AC_PAR_SUBSYSTEM_ID,
>> - .val = QEMU_HDA_ID_MICRO,
>> + .val = QEMU_HDA_ID,
>> },{
>> .id = AC_PAR_NODE_COUNT,
>> .val = 0x00020004,
>> @@ -412,9 +408,9 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>> .name = "out",
>> .params = glue(common_params_audio_lineout_, PARAM),
>> .nparams = ARRAY_SIZE(glue(common_params_audio_lineout_, PARAM)),
>> - .config = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
>> + .config = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>> (AC_JACK_SPEAKER << AC_DEFCFG_DEVICE_SHIFT) |
>> - (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> + (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> (AC_JACK_COLOR_GREEN << AC_DEFCFG_COLOR_SHIFT) |
>> 0x10),
>> .pinctl = AC_PINCTL_OUT_EN,
>> @@ -431,10 +427,10 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>> .name = "in",
>> .params = glue(common_params_audio_linein_, PARAM),
>> .nparams = ARRAY_SIZE(glue(common_params_audio_linein_, PARAM)),
>> - .config = ((AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT) |
>> + .config = ((AC_JACK_PORT_FIXED << AC_DEFCFG_PORT_CONN_SHIFT) |
>> (AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT) |
>> - (AC_JACK_CONN_UNKNOWN << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> - (AC_JACK_COLOR_RED << AC_DEFCFG_COLOR_SHIFT) |
>> + (AC_JACK_CONN_1_8 << AC_DEFCFG_CONN_TYPE_SHIFT) |
>> + (AC_JACK_COLOR_PINK << AC_DEFCFG_COLOR_SHIFT) |
>> 0x20),
>> .pinctl = AC_PINCTL_IN_EN,
>> }
>> @@ -443,14 +439,12 @@ static const desc_node glue(micro_nodes_, PARAM)[] = {
>> /* micro: codec */
>> static const desc_codec glue(micro_, PARAM) = {
>> .name = "micro",
>> - .iid = QEMU_HDA_ID_MICRO,
>> + .iid = QEMU_HDA_ID,
>> .nodes = glue(micro_nodes_, PARAM),
>> .nnodes = ARRAY_SIZE(glue(micro_nodes_, PARAM)),
>> };
>>
>> #undef PARAM
>> #undef HDA_MIXER
>> -#undef QEMU_HDA_ID_OUTPUT
>> -#undef QEMU_HDA_ID_DUPLEX
>> -#undef QEMU_HDA_ID_MICRO
>> +#undef QEMU_HDA_ID
>> #undef QEMU_HDA_AMP_CAPS
>> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
>> index b9ad1f4c39..6999869c70 100644
>> --- a/hw/audio/hda-codec.c
>> +++ b/hw/audio/hda-codec.c
>> @@ -117,7 +117,6 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
>>
>> /* some defines */
>>
>> -#define QEMU_HDA_ID_VENDOR 0x1af4
>> #define QEMU_HDA_PCM_FORMATS (AC_SUPPCM_BITS_16 | \
>> 0x1fc /* 16 -> 96 kHz */)
>> #define QEMU_HDA_AMP_NONE (0)
>> @@ -514,7 +513,7 @@ static void hda_audio_command(HDACodecDevice *hda, uint32_t nid, uint32_t data)
>>
>> node = hda_codec_find_node(a->desc, nid);
>> if (node == NULL) {
>> - goto fail;
>> + goto liaf;
>> }
>> dprint(a, 2, "%s: nid %d (%s), verb 0x%x, payload 0x%x\n",
>> __func__, nid, node->name, verb, payload);
>> @@ -652,6 +651,11 @@ fail:
>> dprint(a, 1, "%s: not handled: nid %d (%s), verb 0x%x, payload 0x%x\n",
>> __func__, nid, node ? node->name : "?", verb, payload);
>> hda_codec_response(hda, true, 0);
>> +
>> +liaf:
> 
> "liaf" is not very descriptive, any better name for this label?
> 
>> + dprint(a, 1, "%s: not handled: nid %d (%s), verb 0x%x, payload 0x%x\n",
>> + __func__, nid, node ? node->name : "?", verb, payload);
>> + hda_codec_response(hda, true, 0x0885);
>> }
>>
>> static void hda_audio_stream(HDACodecDevice *hda, uint32_t stnr, bool running, bool output)
> 
> Regards,
> 
> Phil.

