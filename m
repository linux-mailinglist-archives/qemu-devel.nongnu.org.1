Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4A70FD7B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 20:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1sro-0005ko-JH; Wed, 24 May 2023 14:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1srj-0005kG-KY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:05:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1srh-0008Bk-A9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:05:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30959c0dfd6so1124749f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684951535; x=1687543535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yyc5DvBuxeNgI/lsmvFNUJb3vzcZk2BrdJyyvyHOlsM=;
 b=rYTBPjDvuU+oLcB5AYf9+7OWFMojmI25IcliPjCMv7oh3gGZGt2zx1Ou4IFZ0iL3Us
 zAoXtJn85zsi94Ce6lzSaslCyMlwwKba3nNxXNedAzGRz8rUicRNoJOmRcs7xXkoSqZT
 wQnh+7jg38vTXak0CixHLbaMFT3etU36/BGE5J0KIJovw+9qLMW+QL/oyi3Jz70ELpfd
 gyKjtGMmWoa7EH5GbNzPTw4I2tlAj6TAo2vEwM29WNMbLbiP6IZgbrftNhJaNLGBG8YD
 VdEg7MuBkG8ZIE8UUu/LYuGvfecDRSZKUNoTK6SGsakMxD6ldJqctY7fNp6zdEqcSsXQ
 2f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684951535; x=1687543535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yyc5DvBuxeNgI/lsmvFNUJb3vzcZk2BrdJyyvyHOlsM=;
 b=lndMYecHOJbV83ePe49KtrZCdqqUfoDuiYpSOWJbc44CGeYRd7filkgKmD3zxO+E9M
 pxxeIbG2nlNZz1+qkcU/P2FF7iqiRbJaBGD9lguQ2Go+CvpdUeZebhY7+3W4PeQE7ri5
 Y5mWha80ntqeA16oSbJ3JWBogJvymvpwCAc5VBBbaeKKVegFsPajpfP4KlU+yOQtxRoa
 PlHfmyCe1YHQ+Jccq7MpS6GuAfQZYazTQnfpJaMBR82e9+pefp3YnexHU/lGXtWdVG1N
 dCJowRE5Ifq1U8yaYz2xVRtmPltQevKzO/oON3SGWURw3Hakc8kPqj/zTpTZ91qy9o+x
 ABVQ==
X-Gm-Message-State: AC+VfDwWgeRRsVH7yVGszaK+fSZoN2DpDgyWTB3UTVB5PolDuyjxqh+q
 SdVAFIUBND9itpzq6vBWlWVLgw==
X-Google-Smtp-Source: ACHHUZ72+Yqg9LNmddCd1W6zPsFFVGOVmyWtA/wPV8MsVRwJIntMXCHRTNLHpemtb137uCKYz53+EA==
X-Received: by 2002:a5d:5185:0:b0:309:471c:9916 with SMTP id
 k5-20020a5d5185000000b00309471c9916mr479261wrv.0.1684951535380; 
 Wed, 24 May 2023 11:05:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.135.174])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adffdce000000b003095bd71159sm15429459wrs.7.2023.05.24.11.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 11:05:34 -0700 (PDT)
Message-ID: <f87ac9d2-8eb7-6a5f-9f41-2d615fe9a40a@linaro.org>
Date: Wed, 24 May 2023 20:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] meson.build: Fix glib -Wno-unused-function workaround
Content-Language: en-US
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 hilmd@linaro.org, qemu-devel@nongnu.org
References: <20230524173123.66483-1-nsaenz@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524173123.66483-1-nsaenz@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 19:31, Nicolas Saenz Julienne wrote:
> We want to only enable '-Wno-unused-function' if glib's version is
> smaller than '2.57.2' and has a G_DEFINE_AUTOPTR_CLEANUP_FUNC()
> implementation that doesn't take into account unused functions. But the
> compilation test isn't working as intended as '-Wunused-function' isn't
> enabled while running it.
> 
> Let's enable it.
> 
> Fixes: fc9a809e0d28 ("build: move glib detection and workarounds to meson")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> 
> ---
> 
> Meson logs before:
> 
>    Running compile:
>    Working directory:  /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk
>    Command line:  clang -m64 -mcx16 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk/testfile.c -o /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk/output.obj -c -D_FILE_OFFSET_BITS=64 -O0 -Werror=implicit-function-declaration -Werror=unknown-warning-option -Werror=unused-command-line-argument -Werror=ignored-optimization-argument -std=gnu11 -Werror
> 
>    Code:
> 
>      #include <glib.h>
>      typedef struct Foo {
>        int i;
>      } Foo;
>      static void foo_free(Foo *f)
>      {
>        g_free(f);
>      }
>      G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
>      int main(void) { return 0; }
>    Compiler stdout:
> 
>    Compiler stderr:
> 
> 
> Meson logs after:
> 
>    Running compile:
>    Working directory:  /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u
>    Command line:  clang -m64 -mcx16 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/testfile.c -o /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/output.obj -c -D_FILE_OFFSET_BITS=64 -O0 -Werror=implicit-function-declaration -Werror=unknown-warning-option -Werror=unused-command-line-argument -Werror=ignored-optimization-argument -std=gnu11 -Wunused-function -Werror
> 
>    Code:
> 
>      #include <glib.h>
>      typedef struct Foo {
>        int i;
>      } Foo;
>      static void foo_free(Foo *f)
>      {
>        g_free(f);
>      }
>      G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
>      int main(void) { return 0; }
>    Compiler stdout:
> 
>    Compiler stderr:
>     /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/testfile.c:10:3: error: unused function 'glib_autoptr_cleanup_Foo' [-Werror,-Wunused-function]
>      G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
>      ^
>    /usr/include/glib-2.0/glib/gmacros.h:461:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>      static inline void _GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_ptr) { if (*_ptr) (func) (*_ptr); }         \
>                         ^
>    /usr/include/glib-2.0/glib/gmacros.h:441:43: note: expanded from macro '_GLIB_AUTOPTR_FUNC_NAME'
>    #define _GLIB_AUTOPTR_FUNC_NAME(TypeName) glib_autoptr_cleanup_##TypeName
>                                              ^
>    <scratch space>:58:1: note: expanded from here
>    glib_autoptr_cleanup_Foo
>    ^
> 
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index ef181ff2df..71a4fcee52 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -780,7 +780,7 @@ if not cc.compiles('''
>       g_free(f);
>     }
>     G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
> -  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Werror'])
> +  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Wunused-function', '-Werror'])

Oops, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


