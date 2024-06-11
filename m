Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE23903BF2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jun 2024 14:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0eg-0007kj-SH; Tue, 11 Jun 2024 08:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sH0ee-0007jL-9K; Tue, 11 Jun 2024 08:31:12 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sH0eZ-0000fr-Ap; Tue, 11 Jun 2024 08:31:12 -0400
Message-ID: <49286496-3693-44cd-80ad-afebeb0e9e40@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718109060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAbjyQMcLnrvsFZlrvcKhg4ZEWTMBNVlVjAWxp1fJIM=;
 b=nfC9r0LYqTdMDed1P0TOAGklV6ImgYb+QgsK1rGPAleUkn4+ffJeyDfSMFDN2MMq1ScFwT
 w/qNyxWMBn3dseZq0ZrObqh8FZ7VlUvK2EMQK9elpPR4SP3hXXf8vpVDhaIfLFA4/mD+DE
 fEjYSPoJ5ymbuJC42RIrLcKl6tGB95E=
Date: Tue, 11 Jun 2024 15:31:00 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest/fuzz: fix memleak in qos_fuzz.c
To: alxndr@bu.edu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org
References: <20240521103106.119021-3-frolov@swemel.ru>
Content-Language: en-US
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <20240521103106.119021-3-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping

https://patchew.org/QEMU/20240521103106.119021-3-frolov@swemel.ru/

On 21.05.2024 13:31, Dmitry Frolov wrote:
> Found with fuzzing for qemu-8.2, but also relevant for master
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   tests/qtest/fuzz/qos_fuzz.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index b71e945c5f..d3839bf999 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -180,6 +180,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
>   
>           fuzz_path_vec = path_vec;
>       } else {
> +        g_string_free(cmd_line, true);
>           g_free(path_vec);
>       }
>   


