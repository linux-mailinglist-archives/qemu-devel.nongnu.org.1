Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C8779EB2
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUlHD-0008Am-18; Sat, 12 Aug 2023 05:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUlHB-0008Ad-7K
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:51:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUlH9-00051Y-MF
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:51:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7C64719F91;
 Sat, 12 Aug 2023 12:51:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFFDB1DF53;
 Sat, 12 Aug 2023 12:51:12 +0300 (MSK)
Message-ID: <82aba2ed-bb8c-77ee-5941-9bec0b8be452@tls.msk.ru>
Date: Sat, 12 Aug 2023 12:51:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] meson: Use subprocess.check_output()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20230812091111.13411-1-akihiko.odaki@daynix.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230812091111.13411-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

12.08.2023 12:11, Akihiko Odaki wrote:
> subprocess.check_output() is a more concise way to execute a subprocess
> here.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
> ("[PATCH] meson: Fix MESONINTROSPECT parsing")
> 
>   scripts/symlink-install-tree.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> index b72563895c..56d603588f 100644
> --- a/scripts/symlink-install-tree.py
> +++ b/scripts/symlink-install-tree.py
> @@ -15,8 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>   
>   introspect = os.environ.get('MESONINTROSPECT')
> -out = subprocess.run([*shlex.split(introspect), '--installed'],
> -                     stdout=subprocess.PIPE, check=True).stdout
> +out = subprocess.check_output([*shlex.split(introspect), '--installed'])
>   for source, dest in json.loads(out).items():
>       bundle_dest = destdir_join('qemu-bundle', dest)
>       path = os.path.dirname(bundle_dest)

Yes, this works too and is shorter and easier to read.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks!

/mjt

