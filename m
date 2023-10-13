Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 642287C9048
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 00:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrQdE-0006cP-4J; Fri, 13 Oct 2023 18:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrQdB-0006bS-Pn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 18:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrQdA-0002BK-9O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 18:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697236059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbzJ4p59VknbHdZo5j906NmNiX8r+Ge50Ay/6i/dIjg=;
 b=FuY7eIrKiEsa1J1KKY92FIquOBocPQSnfYaek35kPCvP+oKbGOJSYc9xPqghdvef9BeOvW
 Ma4tCWYK35fVSrCvQyx8AcXYEN/NP5ps5qo5BfOEt4MpS2CZHcg25FOsoqCFSNffPHxNza
 UVBHZQyWsEnm1tqgArVBnknXUjDt/po=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-_oj73ls-OTqYv6E90GnjSg-1; Fri, 13 Oct 2023 18:27:37 -0400
X-MC-Unique: _oj73ls-OTqYv6E90GnjSg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1e9c1e06ce9so2535355fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 15:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697236057; x=1697840857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbzJ4p59VknbHdZo5j906NmNiX8r+Ge50Ay/6i/dIjg=;
 b=sQKawXB2xgJ2tJmUXUdKhj+DtPODkBvI4CzsZBvVkZcph487q03VDqPm5Il/IJQVlX
 34TVDwu1QD9tRXfQvp6jjKMNPwjxCFJin7xY3VAWZfAiFr0uFBVuzrGzuQ4nEippETqz
 SqathAQJBisElzRTwOlHFhhthAN0/jTUGUrn5xzREjDAoMnHgSNHZ3O2YcUFeadZVAHY
 blU3B/thVfjoozMp3+sS9hZtAaG2Vpj57PpyP8vBu4FdRU1VAquFYyrPMSlB1ZQuudY+
 Z4aXJrUyEii1VZRYcStTT/xtZPkFiYb9ejmjo8kVxq+nt+fWkwcw6Iwanl4hQdFMbGgS
 Cm+g==
X-Gm-Message-State: AOJu0YwpuYQ7pVOmUbSNHpU9J+ZBvEMgxDBilfFmVTcaksOh1qFiDykY
 vOJgjWiZceDwOC3seRJNI/8Jj/xCnSVRtesqXUHFSxgkqSLeGXDQNATfiLL58m2UowCBYec4VPE
 JgkxjFJwr6Mr4TQs8f3IADqBynU9mrXg=
X-Received: by 2002:a05:6870:2381:b0:1bb:99fe:6ad1 with SMTP id
 e1-20020a056870238100b001bb99fe6ad1mr33847661oap.6.1697236056820; 
 Fri, 13 Oct 2023 15:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExGpgom5u7H/jk9nzi+vvz628iPLFgkz9ykW8yhYAd8KOt6d2moVwNwY8RVynSL8I1NLR98UzogSPhq9ee+kg=
X-Received: by 2002:a05:6870:2381:b0:1bb:99fe:6ad1 with SMTP id
 e1-20020a056870238100b001bb99fe6ad1mr33847644oap.6.1697236056513; Fri, 13 Oct
 2023 15:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <cef77c3b4f13c967f371d203d1aba515b05f3555.1697183082.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cef77c3b4f13c967f371d203d1aba515b05f3555.1697183082.git.manos.pitsidianakis@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 13 Oct 2023 18:27:25 -0400
Message-ID: <CAFn=p-ZZmrB3LtqAAm1wDB4b1mk6QDq9jz_giSR7TpD9Vkxg0g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/78] hw/ide/atapi.c: add fallthrough pseudo-keyword
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 13, 2023 at 3:50=E2=80=AFAM Emmanouil Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/ide/atapi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index dcc39df9a4..85c74a5ffe 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -1189,53 +1189,54 @@ static void cmd_read_disc_information(IDEState *s=
, uint8_t* buf)
>  static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
>  {
>      int max_len;
>      int media =3D buf[1];
>      int format =3D buf[7];
>      int ret;
>
>      max_len =3D lduw_be_p(buf + 8);
>
>      if (format < 0xff) {
>          if (media_is_cd(s)) {
>              ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
>                                  ASC_INCOMPATIBLE_FORMAT);
>              return;
>          } else if (!media_present(s)) {
>              ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
>                                  ASC_INV_FIELD_IN_CMD_PACKET);
>              return;
>          }
>      }
>
>      memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 =
?
>             IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
>
>      switch (format) {
>          case 0x00 ... 0x7f:
>          case 0xff:
>              if (media =3D=3D 0) {
>                  ret =3D ide_dvd_read_structure(s, format, buf, buf);
>
>                  if (ret < 0) {
>                      ide_atapi_cmd_error(s, ILLEGAL_REQUEST, -ret);
>                  } else {
>                      ide_atapi_cmd_reply(s, ret, max_len);
>                  }
>
>                  break;
>              }
>              /* TODO: BD support, fall through for now */
> +            fallthrough;

ACK. For a moment I was wondering if this was something new to gcc,
but I guess it's just a macro you made O:-)

Acked-by: John Snow <jsnow@redhat.com>

>
>          /* Generic disk structures */
>          case 0x80: /* TODO: AACS volume identifier */
>          case 0x81: /* TODO: AACS media serial number */
>          case 0x82: /* TODO: AACS media identifier */
>          case 0x83: /* TODO: AACS media key block */
>          case 0x90: /* TODO: List of recognized format layers */
>          case 0xc0: /* TODO: Write protection status */
>          default:
>              ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
>                                  ASC_INV_FIELD_IN_CMD_PACKET);
>              break;
>      }
>  }
> --
> 2.39.2
>


