Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DB803768
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:47:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAADv-0005wb-Lg; Mon, 04 Dec 2023 09:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAADt-0005vy-7K
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:47:01 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAADr-00041l-L5
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:47:00 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1faf56466b8so1944936fac.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701701217; x=1702306017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECSPRAPd4OzpboZqLyRqPkuRh/es5tymXvcGE9TzPs=;
 b=PsCvEKx8DUg9EoPIsoak3NjXq6pV25nXCKv5wNX7ou0HJeYSQArUo6CK2j4evfcUEU
 ZB3fw+xOxiCqvR7mGnPGBae0QSRQ7ZtcsQfxe8jrqX/Fq/NkjdNtiC5dZLTqF1gZw7kx
 VtP6SXvL0NmWhzqHzGcnDpq4ExrmJcvuBE2BnbsgkENZxtnAx1VEYRw82kraOYMEWVd0
 hN36ffe19cXXzAR0kOwMpfuo3XG3JT2v+6+coCyBeXa/aQq3gSdoezb+qEMMqVjUDdcY
 jFFU3z7agnqKs2NXm2C6EE/4roKNnKsWlSBPu1mm7ArcbFli1Z3i/Gh3bDj/hfPoZSBF
 BbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701701217; x=1702306017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ECSPRAPd4OzpboZqLyRqPkuRh/es5tymXvcGE9TzPs=;
 b=L//TntK63rreXI7WI7oBae/kKvjtpSRGbo+0vugQPW6Yl45Qalf55SBQaRmTST8Ko/
 pwGzQYj3l755+Lpx+FJk/W64pUPAyUUs2rGjwBL8Anhjbi78LdK4ToFTf7pX9ruczu+7
 nYUQERb0TO2zlaHxHvWHSx7FPN3pnAV52CG1HPkIaXMGcgqEzfh/OFQCobyoEhQrt0UU
 zBAiAnoFFigqEcsv9ac9SQmPNrbWy8BPWOx16o7tmie9BEo4D5H7xTLW3cprYK3Iqzzi
 G0HsiPOK22k6Se4uiCAIxA0FU9LqDu1ZtCHCpRELCLlWznp3+pKR0rA2UWvRJhjg8lkh
 cXqg==
X-Gm-Message-State: AOJu0YyC8iu3Y/q8+cqF3XPmZswJfvaN3/pxNpf440FvXOYRcUPqGF2Y
 WGrDNxcbMgnpARrcKcWhkXHhLP1v+uc8bZ1Gj6U=
X-Google-Smtp-Source: AGHT+IFYK5SzVMOKOmwn9dYwD8wOS9JLHIGyWzn9CTEKPmb21pTPn6vq2NN4jFuZaDO6VpuTj4QDXLoTiAtjRp0G0Lk=
X-Received: by 2002:a05:6870:41c8:b0:1fb:210:5511 with SMTP id
 z8-20020a05687041c800b001fb02105511mr6130361oac.18.1701701217055; Mon, 04 Dec
 2023 06:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20231201205630.10837-1-philmd@linaro.org>
In-Reply-To: <20231201205630.10837-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 4 Dec 2023 09:46:43 -0500
Message-ID: <CAJSP0QWvzeuVvDLwoeZGCPzq_37e6WQRwYp2t3OOe-+jH+ksmQ@mail.gmail.com>
Subject: Re: [PATCH-for-8.2 v2] tests/avocado: Update yamon-bin-02.22.zip URL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Beraldo Leal <bleal@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
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

On Fri, 1 Dec 2023 at 15:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> http://www.imgtec.com/tools/mips-tools/downloads/ redirects
> to https://mips.com/downloads/yamon-version-02-22/ then points
> to an invalid path to a s3 bucket. Use the correct path. The
> site will eventually be fixed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Supersedes: <20231201142139.39816-1-philmd@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  tests/avocado/machine_mips_malta.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks!

Stefan

>
> diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_=
mips_malta.py
> index 9bd54518bf..8e1ee120f4 100644
> --- a/tests/avocado/machine_mips_malta.py
> +++ b/tests/avocado/machine_mips_malta.py
> @@ -124,8 +124,9 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(sel=
f):
>  class MaltaMachine(QemuSystemTest):
>
>      def do_test_yamon(self):
> -        rom_url =3D ('http://www.imgtec.com/tools/mips-tools/downloads/'
> -                   'yamon/yamon-bin-02.22.zip')
> +        rom_url =3D ('https://s3-eu-west-1.amazonaws.com/'
> +                   'downloads-mips/mips-downloads/'
> +                   'YAMON/yamon-bin-02.22.zip')
>          rom_hash =3D '8da7ecddbc5312704b8b324341ee238189bde480'
>          zip_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
>
> --
> 2.41.0
>

