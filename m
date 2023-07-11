Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928AB74E2A8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 02:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ1R4-0004st-A6; Mon, 10 Jul 2023 20:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qJ1R2-0004sg-8w
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 20:40:56 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qJ1R0-0006ae-QB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 20:40:56 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3458a08310aso19698655ab.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 17:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689036053; x=1691628053;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=G2wf0GhwA9ucxzItkheo1H/2PQ4+YyLbcT8VCmiVZNE=;
 b=JjxAIR9+zLhMrc65dBxnSR8IEYXQTWm8uVRdjCvJrj2uAoKioR6CFSyAMFf1aKdPwh
 B4drkNoQnRzgpFWs5hB5wFYqo4Z1pEXVImzVbQ9xGuwU+HUWFkcD8knhprl8Du5vvsJj
 jCgPZ3YpMJLuisadQYRpYXtJC7UhAnZB1HIS0YSHGKGfRnYpbUXy0yT7JVFSEebSjGxt
 HrWNgoo+iHtSBbhxn0YWm8iab7vbjwCto1GVsX4tdP6P0vC7V9gE8Ad1hlNI/ZOaxXJG
 3cR2c41N2MLf6xL/1xEUPzn6R6LBMJbhnmFIYVIDcF1TCH+E2ylA2exOc+pq7os2e9OJ
 nSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689036053; x=1691628053;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2wf0GhwA9ucxzItkheo1H/2PQ4+YyLbcT8VCmiVZNE=;
 b=k1uEwHk5vdjkDFTkzKeb2aKVjxyEoBGZngfLfmAwo84yySp45xGIbd4HrJGLQakTiD
 ZRBJXByp9TwgX5fGp1UK3vA58x8QtA5PP3c1dLk9Vs1GiRfqmd2JnS0XO9sKyjHX3BfF
 wKx/wS31oAkR5rjuvX5sqRJplHRe8IkeDFWZ15A+D6z+JxHAdPaah5dxVXSYXgQSxreX
 6fFQUinEEcZctvKNTWvoM5pz82H67wEHjOqODYFBACImgym94WVc0UK5ziz6XyNIv/BX
 Z1qdRia26ZvWqU5z8C937WKReB2zIXYBisdqLfj9fiyKeZN81s74arhpcNGGrQYz+CsF
 F7vA==
X-Gm-Message-State: ABy/qLZNIjxogC3DAVl3zbVXv+/eHUPM6p6rJWtMmk8iMFcVFY6zjM87
 /Rk6KS2No5WVXKAAyL/KIlY=
X-Google-Smtp-Source: APBJJlHiuVHrskkal21OuSZENl5YExfY4CT+YCpP0J3a86J4x4B9aqSqPH5/Q0Z37v0Gwshbagzrag==
X-Received: by 2002:a92:cac8:0:b0:345:aee1:eae4 with SMTP id
 m8-20020a92cac8000000b00345aee1eae4mr13111230ilq.29.1689036053000; 
 Mon, 10 Jul 2023 17:40:53 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:e850:1a78:8057:4d63:c6a5])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a92cc43000000b00346330d7783sm245298ilq.36.2023.07.10.17.40.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 17:40:52 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>
Cc: <bcain@quicinc.com>, <qemu-devel@nongnu.org>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>
References: <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
 <20230706112234.3267878-1-quic_mathbern@quicinc.com>
In-Reply-To: <20230706112234.3267878-1-quic_mathbern@quicinc.com>
Subject: RE: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
Date: Mon, 10 Jul 2023 18:40:51 -0600
Message-ID: <026701d9b390$585f6690$091e33b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFUW+fyPWhzOeig2J7I77svUZyYDgJG/aCWsKwvspA=
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Thursday, July 6, 2023 5:23 AM
> To: ltaylorsimpson@gmail.com
> Cc: bcain@quicinc.com; qemu-devel@nongnu.org;
> quic_mathbern@quicinc.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org
> Subject: Re: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
> 
> 
> > ltaylorsimpson@gmail.com wrote:
> >
> > > -----Original Message-----
> > > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > > Sent: Wednesday, July 5, 2023 12:35 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: quic_mathbern@quicinc.com; bcain@quicinc.com;
> > > ltaylorsimpson@gmail.com; quic_mliebel@quicinc.com;
> > > richard.henderson@linaro.org
> > > Subject: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
> > >
> > > a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h index
> > > 8f3764d15e..7744e819ef 100644
> > > --- a/target/hexagon/op_helper.h
> > > +++ b/target/hexagon/op_helper.h
> > > +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> > > +                  uint32_t slot, target_ulong vaddr, int size,
> > > +uintptr_t ra);
> >
> > Are you sure this needs to be non-static?
> 
> Yeah, since we remove the mem_load*() functions, check_noshuf() must
> now be visible to the other compilation units that include macros.h, as we
will
> expand the fLOAD() macro to call it.

Since the generated helper functions are included at the bottom of
op_helper.c
    #include "helper_funcs_generated.c.inc"
it can be static.

It needs to be guarded with
    #ifndef CONFIG_HEXAGON_IDEF_PARSER
because it is not used when by any of the idef-parser functions.

Thanks,
Taylor



