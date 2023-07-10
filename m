Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9474DF7B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 22:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIxiO-0007sz-TG; Mon, 10 Jul 2023 16:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIxiL-0007sZ-IE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:42:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIxiD-0005L7-Nr
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:42:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3142a9ffa89so5717818f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689021743; x=1691613743;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A3UVSUoWHokXMAK/ehxvJyXMUiEGObrVtEDbKATYC/c=;
 b=mOKJ1Cezuvbmb4m8So+Nwbwa/AzIBd5oLiG6pEhG3ZFNnoYxB6K0foSnYgiGsBQJVM
 hDlDwJ1p+xJjPWK5Xv9iWyr7QIxpKS+vbsAHzJPpvfeEr5rd80HuqRGVRPM1ahdLrklj
 kal7v9ndX2jbQXZRh3HWoTc0Aw7Q0mmUxuyKpZhz4axzFsn7KkFzHlplq1935oo86WX7
 p7eIJ7rJ9CohWmY5/A+Y28pLSNWq2u8f1Huz8z0tcTt5Zrfb/ar+E8FXrx1AO2ODNitF
 VcrOHkS8awiI3pwAhLIhH6oobfBKRAl6zySHZE/6XmgZt8ptf2ImE8bh8kU1nGtzvjpy
 A6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689021743; x=1691613743;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A3UVSUoWHokXMAK/ehxvJyXMUiEGObrVtEDbKATYC/c=;
 b=XjDEjXWX2TuSbjgsH/tNAVBAdXHML7h7jEKk98ali2nOYq398Pl0wQqkwLyzRh9ZLp
 pGv4Ekn7eujTypI13HoRhuF3+KQPkDds/3TjxrBBq0sqSa2IlYhCoXhbfEJt0GXla2eS
 4i0eOmOX+q4y7kCdM51juP3p7lv0FIdnpRDT8dAoV29JPASsbvBipnVsPMtYdLbLvDhe
 t93s2kroZ785s+Lt0zCWKdbxBavy6U0QCnPkF7NBTOajj/bNma8yCRU0Q9s2OimRaaZg
 Q/YCuonmR1nqDsuIfUPO26/IRAqI/+bN40erouO01rr2FFWipvQMdqKdG4SbyJPYmepE
 UyJQ==
X-Gm-Message-State: ABy/qLblsRc9FaaG1FVDMb8AVIRbJaliNr0LbxH7y9kbxoEb1QddRFs8
 JxGhXwsFU7/V5njmmj9ayXbv4Q==
X-Google-Smtp-Source: APBJJlEo0d151td6kqHrsV01E7zDaOT0YcnJX2pHs0lvRTtiQGw2/HGNWrsc+13f/EjF/Sx5Olvrcg==
X-Received: by 2002:a5d:5444:0:b0:313:fd52:af37 with SMTP id
 w4-20020a5d5444000000b00313fd52af37mr13412520wrv.4.1689021742760; 
 Mon, 10 Jul 2023 13:42:22 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600000ce00b003062b2c5255sm352870wrx.40.2023.07.10.13.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 13:42:22 -0700 (PDT)
Message-ID: <39616c14-22ab-867f-9de3-2de0f269690f@linaro.org>
Date: Mon, 10 Jul 2023 21:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/21] s390x, qtest and misc patches before the 8.1 soft
 freeze
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230710134050.209922-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710134050.209922-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/10/23 14:40, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:
> 
>    Merge tag 'pull-vfio-20230710' ofhttps://github.com/legoater/qemu  into staging (2023-07-10 09:17:06 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-07-10v2
> 
> for you to fetch changes up to 7233bd122370155abfd75a42c86a9087ca5a8dbf:
> 
>    docs/devel: Fix coding style in style.rst (2023-07-10 15:34:57 +0200)
> 
> ----------------------------------------------------------------
> * s390x instruction emulation fixes and corresponding TCG tests
> * Extend the readconfig qtest
> * Introduce "-run-with chroot=..." and deprecate the old "-chroot" option
> * Speed up migration tests
> * Fix coding style in the coding style document

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


