Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549A71946F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4crN-0003bD-Hx; Thu, 01 Jun 2023 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4crL-0003am-14
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4crJ-0008IT-7z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685604992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21eXD0LXVvSjeOmmx5PNXGs5Dwvb9qO04xDRNBmINNc=;
 b=fehB23EVmafmb2tI1mtW6P0h36qf8okOxppYQhubt5+ejnj+NkZFvHpmrCBwkuIOowkwBQ
 77VaV6EvjKnfaQkxiOH3/RPviiJJ1DCNIx5xoFQlKnAGiehxXHX25En80NtKtlTnu9pVkk
 hjaaUBSydyKNHbBjExZFxv2eL4vfpuM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-1pXLpzgcNsSxgFChmJy6UQ-1; Thu, 01 Jun 2023 03:36:31 -0400
X-MC-Unique: 1pXLpzgcNsSxgFChmJy6UQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30ac4ed46e8so731778f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 00:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685604990; x=1688196990;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21eXD0LXVvSjeOmmx5PNXGs5Dwvb9qO04xDRNBmINNc=;
 b=ldlm0xP7Mr6KpqWGehIEVXw/PE0TBrZjr/QqvwlqS2+XTbyAZ2qnSBvFXnv2YHFJ9d
 nsh2BqEDLGMx1u2sJti7uuoDjJROoN7BvRY0/M/YhwBYyeORuWn1FzkiXfgkgZ+dpkkm
 6+Zecj33y734XA22jlOO4vUMx8zGc9MzEh5Ld6HP8Lbt7kq0XfmnLWL5tfHEdJRB3+dK
 zWKoWDJjx2Z2Maf9ScOChzuvHb8AKeWhvzzFXhzriUAGLNEXaWHT3WRvoNkKp7GDWDsc
 sriJ5LBK1y+sAbxR/repyCKguxBwIqkkhD4qbipQThjSxHhw4Ne7kWUehcvKn75MZrI6
 0skw==
X-Gm-Message-State: AC+VfDxc2l2IjZzH1nGpQpdE0AH/ZvnrrgSENIBnTJZYWe4vUst2Wtyi
 tsLvOmjFtEl9ARP6x7MoqVU07QUKrRrETq+IV+WT3rOhVeyDRkK17pfwxcGUpijd7r8+h9GT/qj
 ZNp4XFyfaE1bq/JIaFK3M870=
X-Received: by 2002:a5d:45d2:0:b0:30a:ddb3:93b with SMTP id
 b18-20020a5d45d2000000b0030addb3093bmr1452722wrs.63.1685604990039; 
 Thu, 01 Jun 2023 00:36:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5V5aN8QuYWo+hDw9b5fgX1pIZBxSLtwmN2Db/0dGXHTZHD9rCAUXkwCcq800pGt+FAiZ2gXg==
X-Received: by 2002:a5d:45d2:0:b0:30a:ddb3:93b with SMTP id
 b18-20020a5d45d2000000b0030addb3093bmr1452706wrs.63.1685604989713; 
 Thu, 01 Jun 2023 00:36:29 -0700 (PDT)
Received: from ridgehead.home.lan (cst2-15-35.cust.vodafone.cz. [31.30.15.35])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a5d6546000000b003047ea78b42sm9308480wrv.43.2023.06.01.00.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 00:36:29 -0700 (PDT)
Date: Thu, 1 Jun 2023 09:36:27 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/vm: Introduce
 get_qemu_packages_from_lcitool_vars() helper
Message-ID: <ZHhKe3fzmau7qsMn@ridgehead.home.lan>
References: <20230531200906.17790-1-philmd@linaro.org>
 <20230531200906.17790-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531200906.17790-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Wed, May 31, 2023 at 10:09:05PM +0200, Philippe Mathieu-Daudé wrote:
> The 'lcitool variables $OS qemu' command produces a file containing
> consistent environment variables helpful to build QEMU on $OS.
> In particular the $PKGS variable contains the packages required to
> build QEMU.
> 
> Since some of these files are committed in the repository (see
> 0e103a65ba "gitlab: support for FreeBSD 12, 13 and macOS 11 via
> cirrus-run"), we can parse these files to get the package list
> required to build a VM.
> 
> Add the get_qemu_packages_from_lcitool_vars() helper which return
> such package list from a lcitool env var file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/vm/basevm.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 8ec021ddcf..2632c3d41a 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -522,6 +522,12 @@ def get_qemu_version(qemu_path):
>      version_num = re.split(' |\(', version_line)[3].split('.')[0]
>      return int(version_num)
>  
> +def get_qemu_packages_from_lcitool_vars(vars_path):
> +    """Parse a lcitool variables file and return the PKGS list."""
> +    with open(vars_path, 'r') as fd:
> +        line = list(filter(lambda y: y.startswith('PKGS'), fd.readlines()))[0]
> +        return line.split("'")[1].split()

Nothing wrong with this one, it's also less lines of code, but just an FYI in
case you wanted a slightly more readable (yet a tiny bit less performant piece
of code) you could make use of the JSON format with 'variables --format json'.

Regards,
Erik


