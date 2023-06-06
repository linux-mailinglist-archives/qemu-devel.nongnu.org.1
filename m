Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B0723D37
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Stq-0002X5-MP; Tue, 06 Jun 2023 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6Sto-0002W6-Gm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:22:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6Stm-0004cW-RK
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:22:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51480d3e161so8485719a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686043361; x=1688635361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8jRvt8BXK9EcAiWOn1sVo0UKxCVBS0yEqG7bcFAPdI=;
 b=l4Q+/RxPSDgtsXYMVsquC2y075QzNWeyhgUBwTBy/CF4CPs1eFPaW5Mp3ojaoGfwiV
 EP6E5IOZRJh7b+SAkukTaDJ2FS57MOHrhy9CuLSxfxgtsteKJVRmlF8Rk1t+afVqNKf/
 1MJkswWQCHHpak294EvE5exFMDBPpgOTBHofho4AYNL7Id5cKRaBxPnEGZjlzvNgnt8g
 DSThTd9ZuuWjE04azx4Y4CPrxBYktRQRXYjY7TyPFzI0+EwZdFeNHNQVQWdWXHSwp1kH
 Y0StJ+hhWMgEnV1GKAHJjrD+KHe8dXV9X71B/UT1VDweNg5PVkdxqObEoOMproyYybyz
 PVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686043361; x=1688635361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8jRvt8BXK9EcAiWOn1sVo0UKxCVBS0yEqG7bcFAPdI=;
 b=MTf0mNqCx9+sWcw73DiWsnR4wABT4kgfLOEXcNRIkDoYhZWcgEyF0tc1GTS503CJzf
 SDYKGyafXUEGP25bniRmKh4o8s5rt5VtwEsi9UOHnG4zazP+IN0BFSeu8EhqtDMiAtz/
 kv8KU1QdG/ZN5BmgA/wKrtG8z/9JdrCaQt1HBvy8SWMsMEyD6ptWFEQnkhfm4NN2E4wb
 5O4o123dKgU6ggIsKMDcEI+N1fr8HO0N0pLBFTDrba4lnlkRjqGksI2Rm60GEuiZPltK
 i7kiprOIQH1Gx4mr4LzpW799lwb60yJ3oAL6iQkIxajO7mBZt5HiSX77iiBEWq83Xp70
 PVVA==
X-Gm-Message-State: AC+VfDw47fwbn2q6rxQ1X6w99o9ltUp8XytFKatqvzd/Il0oPVo30Zb8
 SGHuZOf+b3eyVerANIc/M15uW7Wvg429s2cvpYfX6w==
X-Google-Smtp-Source: ACHHUZ4jpPoGpTvnCRUH3oRVRTc/uZia+ZeEIGQmJ+nuZ8Tgbrls3GCNm5V2oBfKv9FNSg4bArW3X6useNGpHSeqrA0=
X-Received: by 2002:a17:907:96a3:b0:96f:f451:1874 with SMTP id
 hd35-20020a17090796a300b0096ff4511874mr2306739ejc.59.1686043361098; Tue, 06
 Jun 2023 02:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230605175647.88395-1-philmd@linaro.org>
 <20230605175647.88395-4-philmd@linaro.org>
In-Reply-To: <20230605175647.88395-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 10:22:07 +0100
Message-ID: <CAFEAcA81sCDGrk+TKe42rQ+w4PMOORsgwj4DZR1Ky29i5SFm8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] qemu/uri: Use QueryParams type definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Jun 2023 at 18:57, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Follow QEMU CODING_STYLE, use the type definition.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/uri.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/uri.h b/include/qemu/uri.h
> index b43f35a6a6..2875c51417 100644
> --- a/include/qemu/uri.h
> +++ b/include/qemu/uri.h
> @@ -96,7 +96,7 @@ typedef struct QueryParams {
>    QueryParam *p;       /* array of parameters */
>  } QueryParams;
>
> -struct QueryParams *query_params_new (int init_alloc);
> +QueryParams *query_params_new (int init_alloc);
>  extern QueryParams *query_params_parse (const char *query);
>  extern void query_params_free (QueryParams *ps);

Also makes that prototype match the following two.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

