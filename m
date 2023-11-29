Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7807FDC2A
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:04:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8N1R-00036o-N1; Wed, 29 Nov 2023 11:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8N1N-00036J-PQ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:02:42 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8N1L-0004N6-5J
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:02:41 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c8880f14eeso88285441fa.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701273757; x=1701878557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAYOTHzF1OaG7TB8X+N7Ima8n16kw44jGX8Iis3iDqs=;
 b=VN/5ZyaEGOR2d/Bez8kaJDht49/zjp05/Y1raJtrwWr0pCPBaAzyRaKi4f/pXKreUN
 Pbd1S09OHsnfPfHhbUan6qSlMHtF3iVMQ2sA4Z/Wn2wreOeGvkkLP7+X2J1aLcFqgwAJ
 mf6jiWi7+xurdHrofAPrbHBBHmOQjeScjEEP/S/G1dmCvq/S6NVH7x5UxEgFiZyxq6pL
 C++Uc74EaQdFvzTcDAv4XQjh6+xw7jMAwXwoDJ+WpekRkgh9ew+oDL6YKuFaLEtcwEXN
 z/WPC4vHOpGV95daLj6f2kJ6o4p7sANjbmhr5jrT2mBEvJYEhZuk4AczL4YC+koWyHS+
 72ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701273757; x=1701878557;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAYOTHzF1OaG7TB8X+N7Ima8n16kw44jGX8Iis3iDqs=;
 b=hPkQpyfjI2QMF6ijXUFn7oyQAti+OeTGQcnI2wfGwHmmjXdNvQknMicSSOYE4mcQvt
 /2A4Xs86+/7JTmgFShirQJbsWk1iIF1GlOOTQhXMkvCY1KXW8WpbNoY9WxjVHBUHVKtj
 +Mc7gKfwU2TCVdeTB6ywDG2g2G1bwFPNZrkD404ftbqNVPQ8awVMrhbEZpiP+H0Lt/IT
 jOSh9n9iOky4IDfV/bQbz02xDmJ5fz6Rg5z2vVEVvR8GKLFGGekqK7UqWEG6qtsuPqY5
 QQ6iGIFeYv/efwLL5Ene6GdevbwNT2tlm+IeSUmJEF4LRNh4fqU/Rff1C9Hk4H2aCeii
 XlaA==
X-Gm-Message-State: AOJu0YyG1d4fNBIs4hiYqT+QyviHSleF+7jOp2KILroUOH7J2YO4z3NB
 p4GNRbDf6G4AZTXt9KK+lQn3eQ==
X-Google-Smtp-Source: AGHT+IFi56qjdPJnsl0pDAXdhQP4zvoq2ix5m8/RpkTpH83iQstJzL/QFDhFwraPveKnW7l6dJFdXQ==
X-Received: by 2002:a2e:2405:0:b0:2c9:b880:9059 with SMTP id
 k5-20020a2e2405000000b002c9b8809059mr3091840ljk.7.1701273756589; 
 Wed, 29 Nov 2023 08:02:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m40-20020a05600c3b2800b004042dbb8925sm2714896wms.38.2023.11.29.08.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:02:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D36BE5F7AF;
 Wed, 29 Nov 2023 16:02:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 04/20] mcdstub: added header with defines specific to
 the mcd tcp packet communication
In-Reply-To: <20231107130323.4126-5-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:07 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-5-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:02:35 +0000
Message-ID: <875y1ka6p0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  include/mcdstub/mcd_shared_defines.h | 108 +++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 include/mcdstub/mcd_shared_defines.h
>
> diff --git a/include/mcdstub/mcd_shared_defines.h b/include/mcdstub/mcd_s=
hared_defines.h
> new file mode 100644
> index 0000000000..fa1adb5c77
> --- /dev/null
> +++ b/include/mcdstub/mcd_shared_defines.h
> @@ -0,0 +1,108 @@
> +/*
> + *this file is shared between the mcd dll and the mcd stub.
> + *it has to be kept exectly the same!
> + */

If this comes from the published API headers it needs clear attribution
and a license header. I assume it won't update anything like as
frequently as our linux and Xen headers so I don't think we need special
tooling to handle updates.

> +
> +#ifndef MCD_SHARED_DEFINES
> +#define MCD_SHARED_DEFINES
> +
> +/* default tcp port */
> +#define MCD_DEFAULT_TCP_PORT "1235"
> +
> +/* tcp data characters */
> +#define TCP_CHAR_OPEN_SERVER 'I'
> +#define TCP_CHAR_OPEN_CORE 'i'
> +#define TCP_CHAR_GO 'C'
> +#define TCP_CHAR_STEP 'c'
> +#define TCP_CHAR_BREAK 'b'
> +#define TCP_CHAR_QUERY 'q'
> +#define TCP_CHAR_CLOSE_SERVER 'D'
> +#define TCP_CHAR_CLOSE_CORE 'd'
> +#define TCP_CHAR_KILLQEMU 'k'
> +#define TCP_CHAR_RESET 'r'
> +#define TCP_CHAR_READ_REGISTER 'p'
> +#define TCP_CHAR_WRITE_REGISTER 'P'
> +#define TCP_CHAR_READ_MEMORY 'm'
> +#define TCP_CHAR_WRITE_MEMORY 'M'
> +#define TCP_CHAR_BREAKPOINT_INSERT 't'
> +#define TCP_CHAR_BREAKPOINT_REMOVE 'T'
> +
> +/* tcp protocol chars */
> +#define TCP_ACKNOWLEDGED '+'
> +#define TCP_NOT_ACKNOWLEDGED '-'
> +#define TCP_COMMAND_START '$'
> +#define TCP_COMMAND_END '#'
> +#define TCP_WAS_LAST '|'
> +#define TCP_WAS_NOT_LAST '~'
> +#define TCP_HANDSHAKE_SUCCESS "shaking your hand"
> +#define TCP_EXECUTION_SUCCESS "success"
> +#define TCP_EXECUTION_ERROR "error"
> +
> +/* tcp query arguments */
> +#define QUERY_FIRST "f"
> +#define QUERY_CONSEQUTIVE "c"
> +#define QUERY_END_INDEX "!"
> +
> +#define QUERY_ARG_SYSTEM "system"
> +#define QUERY_ARG_CORES "cores"
> +#define QUERY_ARG_RESET "reset"
> +#define QUERY_ARG_TRIGGER "trigger"
> +#define QUERY_ARG_MEMORY "memory"
> +#define QUERY_ARG_REGGROUP "reggroup"
> +#define QUERY_ARG_REG "reg"
> +#define QUERY_ARG_STATE "state"
> +
> +/* tcp query packet argument list */
> +#define TCP_ARGUMENT_NAME "name"
> +#define TCP_ARGUMENT_DATA "data"
> +#define TCP_ARGUMENT_ID "id"
> +#define TCP_ARGUMENT_TYPE "type"
> +#define TCP_ARGUMENT_BITS_PER_MAU "bpm"
> +#define TCP_ARGUMENT_INVARIANCE "i"
> +#define TCP_ARGUMENT_ENDIAN "e"
> +#define TCP_ARGUMENT_MIN "min"
> +#define TCP_ARGUMENT_MAX "max"
> +#define TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS "sao"
> +#define TCP_ARGUMENT_REGGROUPID "reggroupid"
> +#define TCP_ARGUMENT_MEMSPACEID "memspaceid"
> +#define TCP_ARGUMENT_SIZE "size"
> +#define TCP_ARGUMENT_THREAD "thread"
> +#define TCP_ARGUMENT_ADDRESS "address"
> +#define TCP_ARGUMENT_STOP_STRING "stop_str"
> +#define TCP_ARGUMENT_INFO_STRING "info_str"
> +#define TCP_ARGUMENT_STATE "state"
> +#define TCP_ARGUMENT_EVENT "event"
> +#define TCP_ARGUMENT_DEVICE "device"
> +#define TCP_ARGUMENT_CORE "core"
> +#define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
> +#define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
> +#define TCP_ARGUMENT_OPTION "option"
> +#define TCP_ARGUMENT_ACTION "action"
> +#define TCP_ARGUMENT_OPCODE "opcode"
> +
> +/* for packets sent to qemu */
> +#define ARGUMENT_SEPARATOR ';'
> +#define NEGATIVE_FLAG 0
> +#define POSITIVE_FLAG 1
> +
> +/* core states */
> +#define CORE_STATE_RUNNING "running"
> +#define CORE_STATE_HALTED "halted"
> +#define CORE_STATE_DEBUG "debug"
> +#define CORE_STATE_UNKNOWN "unknown"
> +
> +/* breakpoint types */
> +#define MCD_BREAKPOINT_HW 1
> +#define MCD_BREAKPOINT_READ 2
> +#define MCD_BREAKPOINT_WRITE 3
> +#define MCD_BREAKPOINT_RW 4
> +
> +/* trigger data */
> +#define MCD_TRIG_ACT_BREAK "check_data_value"
> +#define MCD_TRIG_OPT_VALUE "break_on_trigger"
> +
> +/* register mem space key words */
> +#define MCD_GRP_KEYWORD "GPR"
> +#define MCD_CP_KEYWORD "CP"
> +
> +#endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

