Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54F7031B8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaHA-0005O7-R1; Mon, 15 May 2023 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pyaGz-0005NT-Fv
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:38:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pyaGw-00046l-8m
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:38:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f423c17bafso372105e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684165081; x=1686757081;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gl8x4rAWRd8xfyPT4K5elIQEizFkl0MnikriyEOnKGk=;
 b=dXJF2LddttwVjhJWpqwyrg+V2ggF7eG4SBuSQ6jc90Qek5OocrpORUe8zG0d1LCNN8
 wK9aLTSidzP9FkfQ4DZvbufgPGtDzYcX8INrpb77niiUsuDyAtIOr0Bgt8TatbNObBRB
 TzC8bRIQoWZzDwrB0+kBmU0t55hamuF8JNKu5w5Ylvywoe5bEiVNKa2fGTVFsPXHUMAW
 j6mCnvKZBiMLouSOGTwfCMi/GS2mJrER8XxRcbVuYTdoDMiC1fYKAagBAlwWL4hR4dKl
 FKENUELyrHjzqh6+PNEfKr64s0RK9NAyqz+gQs0tcMpWWVXTzK1z5cJCqV4cHI0sWPpS
 UD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684165081; x=1686757081;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gl8x4rAWRd8xfyPT4K5elIQEizFkl0MnikriyEOnKGk=;
 b=OOEcXqDZ7HCnPu7K7NkQ3FgNkyveKnxp28TgcvhyaHtNrvRK+ZbhNLOtsU0ERvDtTy
 5Q1YxTpXq9QBSzuA3+pMqxDoclNfS3rZ6QaQPaic9ZoEWi0IeHghoSY0CrhvXQrnAt9W
 eXpFBA3Mhx7BEI3EMmIiBKPwsA2Vo5EZyFLaY0g+Cfu1F7iveq1wcQm/e5B4sd7qQlfw
 k1oTHuV579Z4aXp7jMPOyGF0w4RYwELdGzXjxaUihe92BdlyNEkPv0St7BiaFmfOWgUX
 ycD7Jz3U6PEc6BnZto1OpcbjXqP1mzr+lhzeDb0wt3WC4rzIydIFt1TBCwHTEGbaggb5
 baXA==
X-Gm-Message-State: AC+VfDyUvfxqsIU/h1IkYmmOGtkuHnTwP+MoGD3Bdme4M+GrjgTNEczA
 mwtyr/8d8JQPuP8dEQDbqK405A==
X-Google-Smtp-Source: ACHHUZ7cO0Gsv9RpVzP9t8bM03LdHPXCuvJP9Rtn+cVdA5b8sX1IHVvFnOuJX9j8cmktjgw79xcDeg==
X-Received: by 2002:a05:600c:3d93:b0:3f1:758c:dd23 with SMTP id
 bi19-20020a05600c3d9300b003f1758cdd23mr828283wmb.7.1684165080641; 
 Mon, 15 May 2023 08:38:00 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com.
 [34.78.232.44]) by smtp.gmail.com with ESMTPSA id
 u4-20020a05600c00c400b003f4290720d0sm21166093wmm.47.2023.05.15.08.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 08:38:00 -0700 (PDT)
Date: Mon, 15 May 2023 15:37:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v3 05/10] hw/arm/smmuv3: Parse STE config for stage-2
Message-ID: <ZGJR0yYaIxfddu3j@google.com>
References: <20230401104953.1325983-1-smostafa@google.com>
 <20230401104953.1325983-6-smostafa@google.com>
 <c5b495d4-8679-8190-9966-d3ab82cb1a6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5b495d4-8679-8190-9966-d3ab82cb1a6d@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Eric,

Thanks a lot for taking the time to review the patches.

On Mon, May 15, 2023 at 03:03:28PM +0200, Eric Auger wrote:
> >  
> > +/* If stage-1 fault enabled and ptw event targets it. */
> > +#define PTW_FAULT_S1(cfg, event)            ((cfg)->record_faults && \
> > +                                             !(event).u.f_walk_eabt.s2)
> > +/* If stage-2 fault enabled and ptw event targets it. */
> > +#define PTW_FAULT_S2(cfg, event)            ((cfg)->s2cfg.record_faults && \
> > +                                             (event).u.f_walk_eabt.s2)
> > +
> > +#define PTW_FAULT_ALLOWED(cfg, event)       (PTW_FAULT_S1(cfg, event) || \
> > +                                             PTW_FAULT_S2(cfg, event))
> The name of the macro does not really reflect what it tests. I would
> suggest PTW_RECORD_FAULT and PTW_RECORD_S1|S2_FAULT
> I would also suggest (cfg->stage == 1) ?  PTW_RECORD_S1_FAULT(cfg,
> event) :  PTW_RECORD_S2_FAULT(cfg, event)
> 
> PTW_FAULT_S1() and PTW_FAULT_S2() are not used anywhere else.
> 
> I would simplify PTW_RECORD_FAULT(cfg)  (cfg->stage == 1) ?
> (cfg)->record_faults:  (cfg)->s2cfg.record_faults

Yes, this is much simpler.
I am wondering as stage-2 only SMMUs can have stage-1 faults as described in
(IHI 0070.E.a) "3.4 Address sizes".
If the input address of a transaction exceeds the size of the IAS.
I guess this means that the fault record in this case is still controlled by S2R
although it is stage-1 fault as there is no CD or stage-1 config.

Thanks,
Mostafa

