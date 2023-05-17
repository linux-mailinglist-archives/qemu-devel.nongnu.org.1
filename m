Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46AF7073B8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzOSf-0006h3-Dw; Wed, 17 May 2023 17:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOSd-0006gg-LF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOSQ-0006PY-HA
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684357993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykcDPuVoP5Nrhuhgw5V4FPS1V1oPVHdWwkMEzJUOHq4=;
 b=Rs5zLRbnc/xMi9PC4u/jj43Q+6yxwId8RO1/PBDG0O5QGw2T2ZTc29r7zCSUuobmvNgi0F
 1n3G3kh7yXrF2TISD8LLCy2gUOucLOe0sgjzvAxdIROBcaTodgGn5/Oye2B0jsAix6UHUE
 prgY7QYJ78gj/PmRUpdwq2fFIqUpOqU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-R5nq-1-AO7OTCVDzqVEUMg-1; Wed, 17 May 2023 17:13:09 -0400
X-MC-Unique: R5nq-1-AO7OTCVDzqVEUMg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ab28ec0facso8505195ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684357988; x=1686949988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykcDPuVoP5Nrhuhgw5V4FPS1V1oPVHdWwkMEzJUOHq4=;
 b=JP+5wBoTdHdSgTnyq2TDJzMOn3Ff6/Iq1BaolRvvnwsq0Fyv+ITNDpmQoj05WAXNQs
 y4I6aUhk66qHpR+oAJaxZPzuqVZyzW8WKqKZsjY9OlnUjS+9HoyRf8QywlLzCjsV6Nox
 8vq9bOlqw3E9d4Bw5nvMxU6C8po6yDucLreQC6FXe6P8OPb/Vc6qUkA5PREDQQeBKcJB
 5Dek6e4f03zfn7uTjMR8l8N/ohE7u3xp/vE+16pVneQ8CgwZzKUpYzVU5vP0GFLpmFw9
 NC3pvN+qR8WIB3ISqIL4YXWZnQMJlsiuAMck/ZX2/l0uBZirBriMI5Jfj6xZQfK2kjoz
 D1CA==
X-Gm-Message-State: AC+VfDyA3j7K7PTwgqB7TpDpg/qorvRjQ8sjvEkyyqrqELDPA9Ju8Ob2
 AoUXjcFuuB30MLvKPcT3mCTM8uAYsXow8uRIZ/Q42y8hYi7o+DSY58NLL1BB4RzUlSyLRQW7mHm
 a+aT1xbfddwrZ2FrSk3BYPEAtzbl0QNU=
X-Received: by 2002:a17:902:e751:b0:19e:6e00:4676 with SMTP id
 p17-20020a170902e75100b0019e6e004676mr93322plf.61.1684357988531; 
 Wed, 17 May 2023 14:13:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WXyszlCsPfrLfL/S44eqMCbVXMIuomQPOI38gEZP4wsTzfdlBEX1sZfoeFQXtyHgbIS+1RP7cUcEl0fIB2zU=
X-Received: by 2002:a17:902:e751:b0:19e:6e00:4676 with SMTP id
 p17-20020a170902e75100b0019e6e004676mr93310plf.61.1684357988238; Wed, 17 May
 2023 14:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-3-nks@flawful.org>
In-Reply-To: <20230428132124.670840-3-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:12:57 -0400
Message-ID: <CAFn=p-adzHqAMvdYjiMvXpv1-Z3SE78LUErOD5v0yW+6ZZbumw@mail.gmail.com>
Subject: Re: [PATCH 2/9] hw/ide/core: set ERR_STAT in unsupported command
 completion
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Apr 28, 2023 at 9:22=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Currently, the first time sending an unsupported command
> (e.g. READ LOG DMA EXT) will not have ERR_STAT set in the completion.
> Sending the unsupported command again, will correctly have ERR_STAT set.
>
> When ide_cmd_permitted() returns false, it calls ide_abort_command().
> ide_abort_command() first calls ide_transfer_stop(), which will call
> ide_transfer_halt() and ide_cmd_done(), after that ide_abort_command()
> sets ERR_STAT in status.
>
> ide_cmd_done() for AHCI will call ahci_write_fis_d2h() which writes the
> current status in the FIS, and raises an IRQ. (The status here will not
> have ERR_STAT set!).
>
> Thus, we cannot call ide_transfer_stop() before setting ERR_STAT, as
> ide_transfer_stop() will result in the FIS being written and an IRQ
> being raised.
>
> The reason why it works the second time, is that ERR_STAT will still
> be set from the previous command, so when writing the FIS, the
> completion will correctly have ERR_STAT set.
>
> Set ERR_STAT before writing the FIS (calling cmd_done), so that we will
> raise an error IRQ correctly when receiving an unsupported command.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 45d14a25e9..c144d1155d 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -531,9 +531,9 @@ BlockAIOCB *ide_issue_trim(
>
>  void ide_abort_command(IDEState *s)
>  {
> -    ide_transfer_stop(s);
>      s->status =3D READY_STAT | ERR_STAT;
>      s->error =3D ABRT_ERR;
> +    ide_transfer_stop(s);
>  }
>
>  static void ide_set_retry(IDEState *s)
> --
> 2.40.0
>

Seems OK at a glance. Does this change the behavior of
ide_transfer_stop at all? I guess we've been using this order of
operations since 2008 at least. I didn't know C then.

ACK


