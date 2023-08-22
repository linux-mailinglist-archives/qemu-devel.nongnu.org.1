Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2E7841C9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYREm-00081i-2u; Tue, 22 Aug 2023 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYREe-0007nE-J4; Tue, 22 Aug 2023 09:15:57 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYREc-00009y-9W; Tue, 22 Aug 2023 09:15:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-570f0cb0c1eso597935eaf.0; 
 Tue, 22 Aug 2023 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692710148; x=1693314948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D578SCMYgOtKbu1Ia1cvBrYGpAVvaYSuQBja3HEtZwY=;
 b=SoxNDE0Sv3lQSc/AQXHYE+d6ecpxGtG73/99nsXEv3co0siEEyHa4D1XF3f956r2VJ
 sVZjTbuHKQWJ82rzlyn8ETOxTAHOJTq1pMFjrsr8Xhi9brZ1BiFz0YwAYC0sPPwx37I/
 aQyyA+WHQ1ri1ilszX0sFjHoTYQSqQ/CvXdkVy+86NA78MrC738QDPkr27GwV2SYyDWP
 lzH43Nlar3QL5FVloQt4VfE250YEayAcMf6ipNmsNUgUjTdcGptyXKl2LDfn6txfDkeG
 YDKtalI+bRd8tZzcA/NPEeS1LxP2ivQyPYy5nhoNfHYkRKbHIKPhS9jzujIy3xJAE3g5
 4a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710148; x=1693314948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D578SCMYgOtKbu1Ia1cvBrYGpAVvaYSuQBja3HEtZwY=;
 b=J/e/Zg4G3IoJN/ipJm9OVLZI2PHvPIKSbBBxlEAANJGLwkJTpwRzwqpdkhHF6Eo4z0
 FBgsZuPXqqyFaz+oPxpLK/KMqAfAr+JBJboJ96ax/OdbNxkTZ0GPrbS1VxcybzglIlyt
 0it0uABGjvi7o/bAaWRvT3lMVfaPjf9gZ8tuHBHi2323kKO+0kqsOz5X+mj7HcxiVzxF
 EPaB79mYIiWQiZrkPS1QwAJS0JvjRdWrP8GSs9mSu5qrHIj9qRrs99FLWfshjrpAfQT7
 kJaS2xKFYniUaSTfXjOFDR1fslB/Aq7jLPVBAPP15HI5QGWYG6mKmns2HRdwUJR4GN5r
 p9Ng==
X-Gm-Message-State: AOJu0YzHPxzJ1DO6QTd5aR9s0/iL2zdbFNJVFZ7jaMnWTwHy+LKdSxGh
 i3MHIYM8h9gNLCNdYa8ZKVw2Yxsa5TKAqj1A66Y=
X-Google-Smtp-Source: AGHT+IGpXhvJ/1YSr/888OHpL1PUif7Bgn6eq1LlGXlyjSQiMwkbV+rbRCBkEndSXwb7WUNXwHH6/mGzsWN7IuzFfCI=
X-Received: by 2002:a4a:d2d2:0:b0:570:c8fa:4ad7 with SMTP id
 j18-20020a4ad2d2000000b00570c8fa4ad7mr5487849oos.1.1692710148319; Tue, 22 Aug
 2023 06:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822075612.36460-1-philmd@linaro.org>
In-Reply-To: <20230822075612.36460-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 22 Aug 2023 09:15:36 -0400
Message-ID: <CAJSP0QWkM7__n_9DhFBczrX-qt6+tWHZx0qE_yY5B_zUmLN4ow@mail.gmail.com>
Subject: Re: [PATCH] docs/about/license: Update LICENSE URL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-stable@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 22 Aug 2023 at 03:57, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In early 2021 (see commit 2ad784339e "docs: update README to use
> GitLab repo URLs") almost all of the code base was converted to
> point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
> switched from a git mirror to a http redirect to GitLab (see [*]).
>
> Update the LICENSE URL to match its previous content.
>
> [*] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZ=
N4sKDarSeu7DYoRbA@mail.gmail.com/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  docs/about/license.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

