Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D83787649
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDgB-0007qx-IR; Thu, 24 Aug 2023 12:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDg9-0007op-66; Thu, 24 Aug 2023 12:59:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDg7-0003Ww-1t; Thu, 24 Aug 2023 12:59:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so181412a12.0; 
 Thu, 24 Aug 2023 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692896365; x=1693501165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nuoIijA4ltopeBj+rpbSG97puqKa2jt0jOgDepmqi4=;
 b=qekeie2NMZ71rb37tzy8X4LH6NqAvmg8hMjbejDmoZjZjCDuDqVG6Lrm0VkV9M61hE
 AYQARVwT6GqudjAAM8I1tqidX+OTXpF+mB8ls1Wh5W0l0lW9iNl4LKRHyOGGkdT8wraB
 ZPEL3mHTdXBdKbI9nawi2EQ0DIrUE4zHpG3z9+YnAtLpHgIGcPQuVBpvDlokUeg9nEA9
 +jr2Vh1vX6U6HNG5HqMZQfI8X6kAMWO1Anbu/k6rm3uQqyzpVW50YWE+Q7eFPpXsMeUN
 5k/xjnIqi6ZSweuN5fdnBnP+O1nEb4uM75nF1oJ5y+48jzOhSbbkG+OhqERICaIGbOyr
 oiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896365; x=1693501165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nuoIijA4ltopeBj+rpbSG97puqKa2jt0jOgDepmqi4=;
 b=Fgiao/GDskY48Kp6Ikpgg28kCCKC8HmikrAwM1eYqX65JFV4F6eeWBMl3Mhgwwzk0T
 M1cyQ2acEl6gBLjmtCqjiHmMnxM4K9dG6i3jQJrpcgbZhfo4M89EfX4C/suCzNJQlktC
 P2mp8DmXWYyUuHw2d7MILwT71sfCmzNLQAuGB3d4o3uyfKriHmDSCyhcJGVqLmBnoJnf
 hvyO4jUxq/hCCYlBKNKpUqMCohVyydGNdieucPv+xLyUiyL3r3R88qy8NfiJ5G+L8CNA
 ony8wz1sIvnh4jJffTLGDA326Nql4Bk10AdKqg2GS4I4/IWPmA7WBGZaOKUAy4ku+KO4
 QUQA==
X-Gm-Message-State: AOJu0Yypus1Z4mbtIu9kMhX3v1Ihu31INu82WLMfpyAE9y1H/EXylo83
 aqSzNEuUlAOaatjtw5PsxJlQwOIM6xfr5m/Xrj4=
X-Google-Smtp-Source: AGHT+IFLnsd2kYV5LkxEzT/ZD/K8zTRgtwYgVeDeLs5huaeYcqqACPSIHl3m3FjL3eKHtbr++fRHgQHCRca2oJsfdQs=
X-Received: by 2002:aa7:da53:0:b0:523:b37e:b83c with SMTP id
 w19-20020aa7da53000000b00523b37eb83cmr13432556eds.37.1692896364159; Thu, 24
 Aug 2023 09:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230824155345.109765-1-hreitz@redhat.com>
 <20230824155345.109765-3-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-3-hreitz@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 00:58:55 +0800
Message-ID: <CAAAx-8LavGqdDKGnv07PPw6+fYf6a-UOiRvOO2ehP0=8W1U7pQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] file-posix: Check bs->bl.zoned for zone info
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
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

Hanna Czenczek <hreitz@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Instead of checking bs->wps or bs->bl.zone_size for whether zone
> information is present, check bs->bl.zoned.  That is the flag that
> raw_refresh_zoned_limits() reliably sets to indicate zone support.  If
> it is set to something other than BLK_Z_NONE, other values and objects
> like bs->wps and bs->bl.zone_size must be non-null/zero and valid; if it
> is not, we cannot rely on their validity.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/file-posix.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Sam Li <faithilikerun@gmail.com>

