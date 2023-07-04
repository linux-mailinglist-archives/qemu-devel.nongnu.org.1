Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 139D3746DC2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcVh-0004u7-Le; Tue, 04 Jul 2023 05:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qGcVc-0004tr-0j
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qGcVB-000835-7r
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688463554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfYVrOjGXb41c43sRO73a6V62idtsu/h22x7d0l8NVg=;
 b=L0hz2W1nWAz+ML+7kxpw4zlFbXl+4qMOk2RAiMRYvE17t3ilVHB7tINSVSKoddZ0puDcFg
 SYM2+F+V++XVeBndpLeMI3ttUkLHOBLiJa5xVD4/P8qjz1CpRiHlngJScZ/H6GUZeDUiQF
 0ffga/2xzwbo2wItxE688rfJapurAEQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-mWqaELFAMy6hkxzkbHUeSQ-1; Tue, 04 Jul 2023 05:39:13 -0400
X-MC-Unique: mWqaELFAMy6hkxzkbHUeSQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659924cf20so465802985a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688463552; x=1691055552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfYVrOjGXb41c43sRO73a6V62idtsu/h22x7d0l8NVg=;
 b=JeNNiNVMzmqsVuxgDioCzeQR6HcLAKeaN4Olkc+AzRJ2R+NUnZjLtP/gl0npbe4gAO
 5st/SRfxbEmgo9dsqSPa7TS0XP6Cs5x+x6/jHU06zySvGzMpWAcA4Bk95EXeSWL0r/I/
 wy+sDp2Qs5dgtidEThhKVHYQuSvbAX4YGiHlN0xxpcisbYcXMJnNM5PT0OSPzHsZsozn
 +h9zr/5mAygNOJXzRIhhzA/9ZmpqLv7A/tKIz2cpt5VxYhJ0Ky+NKgc5Q/EcV33+kTBe
 uVTUP0T00+ouncber4pOf6g6Pcu0ie3GHG1kaLF1cjOMKQ6YmguMfXIarTNibJn9mYRO
 mMBQ==
X-Gm-Message-State: AC+VfDze8fI7EH6JOybugQ8Rn3Q0pKUFRmOeackH7z5Adn4+YtksXeEc
 ltAmvV23GRYcutThQVz0goPoEk2HJ+zWJqJ6JPwykz049dAtf6fslqqvFjnYfSKT1vSGRoTpifM
 ETyrPdhSkue3h2CgIa6MLhEwsUu/I0WQ=
X-Received: by 2002:a05:620a:2482:b0:767:d0c:9ec1 with SMTP id
 i2-20020a05620a248200b007670d0c9ec1mr13708859qkn.59.1688463552576; 
 Tue, 04 Jul 2023 02:39:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Xs9MxFAH0+vMsNI8g1vPyIb7lNl7JAnVct/sKOgD5UNl6Hv1WKsyFjhPb+fkGLMrXtRcT+KPU7/xxQsFLsg0=
X-Received: by 2002:a05:620a:2482:b0:767:d0c:9ec1 with SMTP id
 i2-20020a05620a248200b007670d0c9ec1mr13708846qkn.59.1688463552285; Tue, 04
 Jul 2023 02:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704084210.101822-1-mcascell@redhat.com>
 <CAJ+F1CLi54BFaeYjZ_eHq+nixPkAcFOGquLx0kRc_YeUeLZVKA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLi54BFaeYjZ_eHq+nixPkAcFOGquLx0kRc_YeUeLZVKA@mail.gmail.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 4 Jul 2023 11:39:01 +0200
Message-ID: <CAA8xKjUTgUfopThem85v9ufQX0=62J5sZxUiKYt0OO6FH-wqEg@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc-clipboard: fix infinite loop in inflate_buffer
 (CVE-2023-3255)
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, kevin.denis@synacktiv.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 4, 2023 at 11:03=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
>
>
> On Tue, Jul 4, 2023 at 10:42=E2=80=AFAM Mauro Matteo Cascella <mcascell@r=
edhat.com> wrote:
>>
>> A wrong exit condition may lead to an infinite loop when inflating a
>> valid zlib buffer containing some extra bytes in the `inflate_buffer`
>> function. The bug only occurs post-authentication. Return the buffer
>> immediately if the end of the compressed data has been reached
>> (Z_STREAM_END).
>>
>> Fixes: CVE-2023-3255
>> Fixes: 0bf41cab ("ui/vnc: clipboard support")
>> Reported-by: Kevin Denis <kevin.denis@synacktiv.com>
>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
>
>
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Note: we may want to disconnect the client when there are extra bytes in =
the message, or print some warnings.

Sure, I guess we can call vnc_disconnect_finish or vnc_client_error
for disconnecting, not sure how to properly print warnings. Feel free
to add that yourself when applying the patch. Or I can try to send v2
if you prefer.

Thanks,

>>
>> ---
>>  ui/vnc-clipboard.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
>> index 8aeadfaa21..c759be3438 100644
>> --- a/ui/vnc-clipboard.c
>> +++ b/ui/vnc-clipboard.c
>> @@ -50,8 +50,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t =
in_len, uint32_t *size)
>>          ret =3D inflate(&stream, Z_FINISH);
>>          switch (ret) {
>>          case Z_OK:
>> -        case Z_STREAM_END:
>>              break;
>> +        case Z_STREAM_END:
>> +            *size =3D stream.total_out;
>> +            inflateEnd(&stream);
>> +            return out;
>>          case Z_BUF_ERROR:
>>              out_len <<=3D 1;
>>              if (out_len > (1 << 20)) {
>> @@ -66,11 +69,6 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t =
in_len, uint32_t *size)
>>          }
>>      }
>>
>> -    *size =3D stream.total_out;
>> -    inflateEnd(&stream);
>> -
>> -    return out;
>> -
>>  err_end:
>>      inflateEnd(&stream);
>>  err:
>> --
>> 2.41.0
>>
>>
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


