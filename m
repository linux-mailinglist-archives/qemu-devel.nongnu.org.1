Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4847762808
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 03:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOT32-0005dr-97; Tue, 25 Jul 2023 21:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qOT2x-0005dJ-Qx
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 21:10:37 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qOT2w-0007DW-2t
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 21:10:35 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991c786369cso952306766b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690333829; x=1690938629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJ4lfL0GXep5g+fTvzH5INlAouvz2XhJhb6DInty43o=;
 b=M8JCPPYAdCFmhXsyuAGR6OD4wtA6JoqWsyubBtXCOLRkOcTtih8sPrLhzojrChIpF+
 w6jzRIsJCWFtLo+PoBcCYEXPe0u2Q47PE+PmPeCf/l7w/JQ6FYo7ZkOKwjqRaxy0Z6fV
 dXDG50vXzstkgWT7N7L0MluWzUdKJ9Q632D6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690333829; x=1690938629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJ4lfL0GXep5g+fTvzH5INlAouvz2XhJhb6DInty43o=;
 b=J9SLHK0Eahe/E3Ri6yGydo7WOVlIxSFAJEuOfquzstSstTOrKuxpyEkON2ztU3Ogx7
 EMhdgeixxKpc1ze7amCPL8QF7Ks89R+Lo4B2Zi+wewrz+YTKeEmA0MZVQCZDf11HI8dO
 dlWKWGDFE4wOaDosUC/o4G7l1bEnhXkngExVudIiRJUhv21th9IQe9bobeA4M2k4jFW1
 5zWDI2ErpufCoY6ZFEvEv8hI3am4pq/A9x3uFQvUXHTZRaTRXiKTpEV0DWsN/mV5PmFS
 FYcYu9Ql2aYQ9kdQ8iDDSpO+wrdWbsA8zBj9uQjjgYX7PWZSG5B4sfNDwD1LoRzhWvYZ
 zfgA==
X-Gm-Message-State: ABy/qLaN1jV6flLoJZlIbarxW/6tFSdQAhAlwqDSONpdhtnsiA388nR1
 DcgFAGow5S6fxH38KFdk3dKp9XF3F8F9SXlwdhgx3w==
X-Google-Smtp-Source: APBJJlHzZnaey0v06GikBmCFNe+8AxJGNqieys2inEdQ9BlClg6LhQ6Ii8jccW6747vsAYCG/6VV+w==
X-Received: by 2002:a17:906:738b:b0:993:dcca:9607 with SMTP id
 f11-20020a170906738b00b00993dcca9607mr386560ejl.2.1690333829188; 
 Tue, 25 Jul 2023 18:10:29 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 rv7-20020a17090710c700b00993a9a951fasm9021552ejb.11.2023.07.25.18.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 18:10:29 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-516500163b2so2951a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 18:10:28 -0700 (PDT)
X-Received: by 2002:a50:d0c9:0:b0:522:2dd2:afa5 with SMTP id
 g9-20020a50d0c9000000b005222dd2afa5mr200901edf.7.1690333828241; Tue, 25 Jul
 2023 18:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <87351diqf9.fsf@alyssa.is>
In-Reply-To: <87351diqf9.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 25 Jul 2023 18:10:15 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
Message-ID: <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] gfxstream + rutabaga_gfx
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jul 24, 2023 at 2:56=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > In terms of API stability/versioning/packaging, once this series is
> > reviewed, the plan is to cut a "gfxstream upstream release branch".  We
> > will have the same API guarantees as any other QEMU project then, i.e n=
o
> > breaking API changes for 5 years.
>
> What about Rutabaga?

Yes, rutabaga + gfxstream will both be versioned and maintain API
backwards compatibility in line with QEMU guidelines.

