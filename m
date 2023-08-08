Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A517739F3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLBC-0006YU-Ue; Tue, 08 Aug 2023 07:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTLB8-0006YF-PZ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:47:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTLB7-0007Nt-60
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:47:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31759e6a4a1so4149207f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691495227; x=1692100027;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7UYqbxhu1e9laO8tO9PphfAwZjizzg1sYeWPORwvNo=;
 b=wQImwks3gPvOabUHtSk/M7PDt42YfzyZV1HFHQFMZmOkr8vKdMpB+F+MfcxjeoS4jn
 2niT4ize+YdmsrCb6p3+//RwkqF8yUwQa/wp32QzcNDzDYBBhADejS0vxdIV5VR1Oeky
 LVtqe2vG6Z4BbnBY9+2ToZgcb1FpbsnyRTBo5kv185ajSy162QH+Y+3DapfNrkESkePX
 gkbIyeNgW3IepoLwItXnu1wTefhJXIYpK1/A30QfyBTvMbd3fSFAgYt2+vxlIwEVjs98
 LfsIEA6slu8VgqSTbkA+SArVCk9lsmOavrW7md0iOXOvsAL9C+TUEFIOXw6uXQJUMrV4
 qjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691495227; x=1692100027;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I7UYqbxhu1e9laO8tO9PphfAwZjizzg1sYeWPORwvNo=;
 b=kdjJb8vaBfLVdrH46e0rIPyptU0Xs6ZwxjR1R4z/E5gbTTS0TlATVrsaHrSL49tFGR
 W+p8CNwVXKu0PsEOUisDZAT3OoI8S+xgfxrwEB67Y3jGnamt3UhnScmGHu/kzsduDEtE
 tQOV77sf3MONCcXakwwn2yv7xlJoAU62sTQYGkCvzRv7ZVunYsEh0ARedwMTpU/dvhk9
 WgZorXHmNBKsXGH/Avs4tLCTa5XTiiToy+iiqXC4G9TSS6jb8KIbz5O+EB3Gri9NzOzt
 yupgTyJgI49oXq3S4bPLYRWKex3TqmC9TEwbe778JdW8u2LOhE1OPqekPbXZQ+xI0tpT
 dg2g==
X-Gm-Message-State: AOJu0YxOn7xgE9WMydiIjEEx2o8/yQXAamJSOMr1XfkNkYVZBM44rq/3
 3ohn6YZQNWuv8xZ33mQC62v/2A==
X-Google-Smtp-Source: AGHT+IEcOpqQ4KbOaO9cCQNqvQ3ECSdNzs7g8XdlEgsyAb3pQ+KBHuqIMGKSOZj5X9j2FglbPz/CJg==
X-Received: by 2002:a5d:6082:0:b0:317:ef76:b776 with SMTP id
 w2-20020a5d6082000000b00317ef76b776mr3206239wrt.68.1691495227676; 
 Tue, 08 Aug 2023 04:47:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d5612000000b00317e9c05d35sm6448809wrv.85.2023.08.08.04.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 04:47:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCAB51FFBB;
 Tue,  8 Aug 2023 12:47:06 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-13-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 12/14] linux-user: Consolidate guest bounds
 check in probe_guest_base
Date: Tue, 08 Aug 2023 12:46:59 +0100
In-reply-to: <20230807163705.9848-13-richard.henderson@linaro.org>
Message-ID: <87ttt97o3p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> The three sets of checks are identical, logically.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

