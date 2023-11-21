Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8627F30FE
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:34:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ros-0003LN-Dr; Tue, 21 Nov 2023 09:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Rol-0003Jc-Sk
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:33:35 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Roi-00068f-TD
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:33:35 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-548d1f8b388so2821740a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700577208; x=1701182008; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T3+1evC7+nXt8ShBdl2MW6CM3EnbRPjJ7TjvfT/jdUw=;
 b=KgC3QbJTOigcAFreZhDWbKcmj2QvuO6CT0+0SaaO6076fLO8SzKNtch9XELuhoITG0
 8CtBpxg2yGXVuYOjPhA37qDDm6ieu9EeMaEuzr924uFR2AcQhMhxEkHn1vUA4tPQAAZL
 MTFgLfmcbVfl7kvbLF0FeDvZpWICr8Z31ma90Abx2lb2PB0ex0X/60Vx64REVWQLlLys
 z/u0wNbR2QtIQPni52sdXmsiwhmxZYLdSeEL2xoveVivSR6oSExMHz5K2ZYMd5v8/JlD
 9iYhJoGUz8onvt+uaR2ueCwANXo3D3XsFQw9hvLf4ZfeImwoYgFgmQeyaUYjhvsOunAp
 4jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700577208; x=1701182008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3+1evC7+nXt8ShBdl2MW6CM3EnbRPjJ7TjvfT/jdUw=;
 b=YJVuC50mPiMOHXT4n/W/SgpZRtr3qqjXs9c98nNpIOTEJ1WKCtnCBj/zcKDFVSI/uQ
 Ke5q3VkjzHSbzDdoEb7Y3UM8SOOSfZUjvVIJRkJ/Qlte1uh3veAuHGxTxv9/oeTO/mWA
 eLqq/dTh39YKNtkERSZznV5tixqgWm6R+atJsbgSb6cGMRyuVmF1OevgqR/Mzv7u9OIH
 85ArJBtSv9WLnhyCZHhjnYo7SrXyETFYIcqAroa9qbty17CSW9kJgqnjl/MlitbteplC
 ovg8ftquq5P/475unR9iuV4JpepIm3+wDlHKjmtZ0RUE2MASGt0ZGAShpRbVXOOi7Cke
 jLAA==
X-Gm-Message-State: AOJu0YyqLmbN/8rDCD7ydrLcKmsI8fbyIRYsR5JtWMcD4uWHCArF9+tJ
 nJzrU1lrws4Yeeu6ZWscFr81BjrY6QVvzGcD3WxDZw==
X-Google-Smtp-Source: AGHT+IEG5MTZBqctIH2mopC4Jb1JkNbiS9NYq9BSx8l7wvWpq+zBdlJJpv8fG6jQ3sLPSljRbmc6og0Ms4LLHnXYP9A=
X-Received: by 2002:a50:ba81:0:b0:53e:72be:2b31 with SMTP id
 x1-20020a50ba81000000b0053e72be2b31mr1741106ede.42.1700577208437; Tue, 21 Nov
 2023 06:33:28 -0800 (PST)
MIME-Version: 1.0
References: <1635974247-1820-1-git-send-email-tsimpson@quicinc.com>
 <1635974247-1820-26-git-send-email-tsimpson@quicinc.com>
In-Reply-To: <1635974247-1820-26-git-send-email-tsimpson@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2023 14:33:17 +0000
Message-ID: <CAFEAcA-rPwmE1oXoPROUEfpa+CDL0zFK5U5N=wPVhWtBif-b9Q@mail.gmail.com>
Subject: Re: [PULL v2 25/30] Hexagon HVX (target/hexagon) instruction decoding
To: Taylor Simpson <tsimpson@quicinc.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, f4bug@amsat.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 3 Nov 2021 at 21:17, Taylor Simpson <tsimpson@quicinc.com> wrote:
>
> Add new file to target/hexagon/meson.build
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>

Hi; Coverity points out a variable written to and then
overwritten before it's ever used in this function (CID 1527408):




> +static void
> +check_new_value(Packet *pkt)
> +{
> +    /* .new value for a MMVector store */
> +    int i, j;
> +    const char *reginfo;
> +    const char *destletters;
> +    const char *dststr = NULL;
> +    uint16_t def_opcode;
> +    char letter;
> +    int def_regnum;

def_regnum has function level scope...

> +
> +    for (i = 1; i < pkt->num_insns; i++) {
> +        uint16_t use_opcode = pkt->insn[i].opcode;
> +        if (GET_ATTRIB(use_opcode, A_DOTNEWVALUE) &&
> +            GET_ATTRIB(use_opcode, A_CVI) &&
> +            GET_ATTRIB(use_opcode, A_STORE)) {
> +            int use_regidx = strchr(opcode_reginfo[use_opcode], 's') -
> +                opcode_reginfo[use_opcode];
> +            /*
> +             * What's encoded at the N-field is the offset to who's producing
> +             * the value.
> +             * Shift off the LSB which indicates odd/even register.
> +             */
> +            int def_off = ((pkt->insn[i].regno[use_regidx]) >> 1);
> +            int def_oreg = pkt->insn[i].regno[use_regidx] & 1;
> +            int def_idx = -1;
> +            for (j = i - 1; (j >= 0) && (def_off >= 0); j--) {
> +                if (!GET_ATTRIB(pkt->insn[j].opcode, A_CVI)) {
> +                    continue;
> +                }
> +                def_off--;
> +                if (def_off == 0) {
> +                    def_idx = j;
> +                    break;
> +                }
> +            }
> +            /*
> +             * Check for a badly encoded N-field which points to an instruction
> +             * out-of-range
> +             */
> +            g_assert(!((def_off != 0) || (def_idx < 0) ||
> +                       (def_idx > (pkt->num_insns - 1))));
> +
> +            /* def_idx is the index of the producer */
> +            def_opcode = pkt->insn[def_idx].opcode;
> +            reginfo = opcode_reginfo[def_opcode];
> +            destletters = "dexy";
> +            for (j = 0; (letter = destletters[j]) != 0; j++) {
> +                dststr = strchr(reginfo, letter);
> +                if (dststr != NULL) {
> +                    break;
> +                }
> +            }
> +            if ((dststr == NULL)  && GET_ATTRIB(def_opcode, A_CVI_GATHER)) {
> +                def_regnum = 0;

In this half of the if() we set it to 0...

> +                pkt->insn[i].regno[use_regidx] = def_oreg;
> +                pkt->insn[i].new_value_producer_slot = pkt->insn[def_idx].slot;
> +            } else {
> +                if (dststr == NULL) {
> +                    /* still not there, we have a bad packet */
> +                    g_assert_not_reached();
> +                }
> +                def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
> +                /* Now patch up the consumer with the register number */
> +                pkt->insn[i].regno[use_regidx] = def_regnum ^ def_oreg;
> +                /* special case for (Vx,Vy) */
> +                dststr = strchr(reginfo, 'y');
> +                if (def_oreg && strchr(reginfo, 'x') && dststr) {
> +                    def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
> +                    pkt->insn[i].regno[use_regidx] = def_regnum;
> +                }

...but the only place we read def_regnum is in this other half of the
if(), and if we get here then we've set it to something out of pxt->insn.

Were we supposed to do something with def_regnum outside this if(),
or could we instead drop the initialization in the first half of the if()
and move its declaration inside this else {} block ?

> +                /*
> +                 * We need to remember who produces this value to later
> +                 * check if it was dynamically cancelled
> +                 */
> +                pkt->insn[i].new_value_producer_slot = pkt->insn[def_idx].slot;
> +            }
> +        }
> +    }
> +}

thanks
-- PMM

