Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8757438C1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAqT-0006zD-AW; Fri, 30 Jun 2023 05:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAqR-0006yo-0B
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:55:15 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAqP-00049s-Ct
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:55:14 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b69e6cce7dso25658871fa.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688118911; x=1690710911;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3NI1W9jnsoiyjiUD/WIcQ6YQo4/JPNx/MTqRqtx4Ni8=;
 b=J1mZfAnC2LDxM4QwLi/RgaIv43re57pkF1ZBMUF+VWukqUQk2S4r7TWL5qZvIjDAFm
 qlIXgtlKI1j+HUkDGA1E/+Wdv4WkNPLRootcvq+OpI+vmP4MdI8wQiLkmtU5S+PkhXRJ
 zHqyHEhcgtiOuEFLyudyGD74dUpNpeHwEIrqLdCuG+qtwJ3y6tEl2aVFC6fLHXa45OuZ
 gjo6D1gJtbVa59pJR3EFjlmpwSFfsLyzChcpeXa36C/eaTbXIYV+JvxAZBBsmFDQuy9D
 oVaYwK9V1UpoJADrOUxRcI4dORrSYW3+DRULH3deVYigq0rdKD2DzkKn9mWU8B3FAowi
 A18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688118911; x=1690710911;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3NI1W9jnsoiyjiUD/WIcQ6YQo4/JPNx/MTqRqtx4Ni8=;
 b=cEUDSLiWI0pX6Dq2X+vai5WK9mwOjcq5ZU2NBnbaKcE8/zg9TKraVpmEAJEpzDdTZ5
 BK2Wh00YxZyit5JRgf8ES7lDueF8TS2BmKcOspp137kuJpaeCIWRrwYgSer/QsE4si/D
 zLw7olrZ+qxbWUvSPVtfcF9EDCIpnCxFfy1PUPHK28EFB9y+ZQfXpWaxzubWyV2+itiQ
 LmMTFYMM+dgn3DLzqzyWzCr4HJD8YuyB2W75j5NZ0ZR5P7PoH32Se4EyWxQiWwp96aHw
 b9HURCelkLdoy5mnrDtIf6taUE0WYSQ4eIKbO8CL+xKbA436w0UCHTPrta0UAUgnHOVR
 MbOQ==
X-Gm-Message-State: ABy/qLa5kEfQWvaeKCA9b6z1BE5PvLDEvcxDFuaqf9v9fmy/HEBcI/cn
 /9daSuQxBe7xdtZkgrY1nzGQlNpbMFMct8ffVJIugg==
X-Google-Smtp-Source: APBJJlHgD8Gfj4TxE1pVaWkDt3Zk+qgvz/M2BveySHp59ZyQTSD983M5MSjBqZ4px5jF6wuc1ipkkg==
X-Received: by 2002:a05:6512:2211:b0:4fb:8948:2b2b with SMTP id
 h17-20020a056512221100b004fb89482b2bmr2557629lfu.48.1688118911075; 
 Fri, 30 Jun 2023 02:55:11 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0ac100b003fba6a0c881sm9347769wmr.43.2023.06.30.02.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 02:55:10 -0700 (PDT)
Message-ID: <f54d81cb-4967-e1f9-86a6-7b892ef9982c@linaro.org>
Date: Fri, 30 Jun 2023 11:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/8] s390-ccw bios updates
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230629190310.337850-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230629190310.337850-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/29/23 21:03, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 0eb8f90edebc11022a42abb211b026fac2e276f5:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin  into staging (2023-06-28 17:29:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-06-29
> 
> for you to fetch changes up to b806bc8d9cc16172f0cf2c9e42ca1d75b72f6555:
> 
>    pc-bios: Update the s390 bios images with the recent changes (2023-06-29 20:47:45 +0200)
> 
> ----------------------------------------------------------------
> * Fix a compilation issue in the s390-ccw bios with Clang + binutils 2.40
> * Create an initial stack frame for the main() function of the s390-ccw bios
> * Clean up type definitions in the s390-ccw bios

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


