Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969D716BBF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dJ-0007mM-V8; Tue, 30 May 2023 13:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q43dH-0007mB-3h
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:59:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q43dF-000269-0t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:59:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-256422ad25dso2554426a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685469579; x=1688061579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gmej3Y58P5XFwDMWZ1RnwDAf1cV0iXNz6g9fKBkSDyM=;
 b=aMQFd1AYVBxOYmdFFvXBxWvSMzR6667vzkJVMVFVC6U4qD/ly5gB9IzdS4CcS8Wgfh
 TS8tHSixIhNjy0JmslB57gjIBpDBNhG2dO307lOWW7BXr3UB7M5WZCSQe1bEMn44RJnv
 9Jw3ar0JgueRXe3mw8N5otNhBJ/isD1lwQJbD46X/mJazBs+Xos3aCzMRGkkP7fQYAEU
 jX0DCe9zt9m1F85RnZmBO/4eYeFG/zNw7dlZsJngG3PmNN65uuH+ONh2/iO1eSNAetWR
 kFOElITmd8tHFnTZ+QFSmqwaHzCZ5p1AuI5vdRU9xptqNYo9sSCorQWodOO0H5/wwmV9
 SZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685469579; x=1688061579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gmej3Y58P5XFwDMWZ1RnwDAf1cV0iXNz6g9fKBkSDyM=;
 b=BxNwzfPpes8SW5rhR7DmoM01obtzCXa0igIqzfbSjsp64Y/sRW3XyLcmfm9k/Ac+bu
 pTCMa9f8P8znKAWO0GUQdIpm8Vli36NZlazncW9mKNoExeCFU1pZ2yKfVnHaAba++Z+4
 pVRfyA69Nq+HiZ22RHdNJEQGtaSTfiX9mZ4cLgzmnTk77vG5CSmq7ebw8pPr4V5pzZ3w
 flj2Nq8TZse4Yc4HUlT+aO5HdmDCcphXD/fktJ0jN7HN0Qcl1VsOhF6riBMPQwVs2D/P
 z65/3HDjI4Gc57CeD0uAaULgfkr6Xxu1LY5qW0JVGkqmiPLJ4ku+FJ1sZoqLG5GrGda1
 6/XA==
X-Gm-Message-State: AC+VfDxqiJmXyRpsbgFFw2tBGRBHhDideKG2Qv3zH+4cZKLAFf0pn+eh
 415DyBARd7YmiVNlszNW5DzfI6FyjShiBBb283q7Fw==
X-Google-Smtp-Source: ACHHUZ4a3W/xJ0Bk2Q3K7m4Xpwg972HQgg/OpJDd2XGzbaC4HrIKAQCHGzLGZ6wZfRmyRmWj/jfamQF4X409MeFlBKI=
X-Received: by 2002:a17:90a:9a9:b0:255:c829:b638 with SMTP id
 38-20020a17090a09a900b00255c829b638mr3477872pjo.9.1685469579362; Tue, 30 May
 2023 10:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR11MB6744115555A361C057C82C30924B9@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744115555A361C057C82C30924B9@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 30 May 2023 10:59:28 -0700
Message-ID: <CAAYibXhx=8O7QaUoPfxNoH4EcVqbTHKsmQFGcnc_V1hadvGMFg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/4] Implement zero page checking using DSA.
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-pj1-x102f.google.com
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

On Tue, May 30, 2023 at 2:26=E2=80=AFAM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
> Hi Hao,
>
> > +    memset(&descriptor, 0, sizeof(descriptor));
> > +
> > +    descriptor.opcode =3D DSA_OPCODE_COMPARE;
>
> What about using DSA_OPCODE_COMPVAL with zero?
> DSA_OPCODE_COMPARE consumes double bandwidth by reading
> from both src and dest address.
>

Agreed,. That's a good idea! I will switch to use DSA_OPCODE_COMPARE
and perform some benchmark testing.

> Thanks
> Zhenzhong

