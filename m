Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA776FE4B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrsi-0002gU-4D; Fri, 04 Aug 2023 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrse-0002gL-6x
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:18:00 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrsc-0003y6-Eo
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144274; x=1691749074; i=deller@gmx.de;
 bh=RCIzYwwujuJL6Tbhq+H1QIzyGSmoIcM8zvSTFldKRMQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Rp5gfayiA35/Neksqmp2TjffoL/R8S/JmB7X+A+BA385wxN2CfzHeo45S1E1Eqn7EzNCKXE
 iS3kdsZtI3IWDLKgYdCP8a/v/4a2itHETqwsPXbz2+Wseqo+oiFFVAr62FbkvzvziFdoFGpCg
 3WS7/cPRewyNVIChDmsYoBtb3qOvJTYXgwdVpdmDIf2loLHN3eKwA7njP3QBL/sbJIDT9cqDw
 kh37IY8cD4GxgdKN+mRjM/eU6cfFhJk7OgE17P/U4qT2pIwEI/T+FPSQmZOrDGdRAnhxp3Waz
 Gq6mYcwO1rwaMq45lNN5Qo33yf9+iGx3xzZpiX2z0ge4xsmGfhxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1qdimn2nV5-00GM2o; Fri, 04
 Aug 2023 12:17:54 +0200
Date: Fri, 4 Aug 2023 12:17:52 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 09/17] linux-user: Define TASK_UNMAPPED_BASE in
 $guest/target_mman.h
Message-ID: <ZMzQUIwArpkWw+71@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-10-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:Lou1X9U4sLeg5GrnWV9st1e3aHelfUjr3FSXegO9UL6QUgEWXkM
 urgwjaOTCaN39tJxZqRSpBUoEXCx25srrWSFxg//vge3XQXw4GEM5ZJB/QR/ENASd9BKJnw
 YVfNZ3kSHsEoBu+629Mu1dMZ6BQZEhkIqFCY1k7sIcLfC4IJ5gdkcq2OFB5tP0BKLrvmH+X
 B9IRWydBRvaT2Sb4DT1gA==
UI-OutboundReport: notjunk:1;M01:P0:pvPzJ4QJ6zU=;LOyllbmQeA46ZC4SrdL9+xSbkpl
 W1Oh18n2xpyKCiIX925Dif/LhqrDOvC+JBGf5EZtMyvOhh57dqTx5wjr8m3AEOGz3wNXTkMhD
 uKR6FGbY/FgF6uH6qaH9kbUSf/ti6KVV4Wdl1L1eCIxfEeMEY2mrN9wms9Sv+ydbadYT65oIr
 wRnXmUyyvBcwj28CK5qWXHc9qZ81cU3BY9uNFkNY7/U2Ulu8ZSBWMJs9TPXPoG3wX/C+MZK6M
 vb85obxILbEb1vSvvRhG0JntOZC8OsYQ2fBm2DwJRuVlXIhGZuMFz2/BCIkZZCQ8cP2rkw2Gp
 J9cz6xrqybybkzAzypwB14vUJ82i3BTX1QBJdKQ/22uiF8ac4XXSVFdYnVwz+6tq/VtrUqWkx
 12XzJirVJ5+O+mWNlV3qxRCR3rajc/20m4ZIy5sUoOkORHTOHPFK9ik0LLrNlhSzBeM0k/tly
 6TwEgxOsC/XeGj8Co4dhTauw1VSBE3ja2wyJj03bCwAijctzMv9ICrlfGbHAO6I5N6hBKj1IA
 4nXCI0pyNfiqDS5F5aVhdHk3+GSY91SMsRG8KkBlMHcab0IqaYsbmEB6P4gBGeGG6IoA1ZBNk
 PoKlAhbbZUHOs5UyEkg4CPadpn9FQpcFXmtpRmu0soMH7KrvQerlGf3oaLt1Q2+xbKN8D4QWb
 sG3aAqBJ57K6cwWpK6Ky001ZCDg81Nq53bIXWwjeKva9X0hQj1azmK0VFE6ozo6UfvclRYu6l
 2UaYVL6Iwzd0+vZEVHDyBKxzNHqxFr0Q8WEDRax9nPG2Xp9gKsL8w89EkE2+jkztWCAG10CcS
 zus7N1lVYZftPAOAGJw1/wsQJ1WvS/ec2lRcaTXo1feDn6RIqVEVVZEAseJ2Vzaz7Hg0EQ1iB
 SeHLIjt+PtXPG8rxL9OYVFbVYc+J3x2lDGfw/7dvjCOAS6UZEQblV3NTQ6g8pM2neWjxzq8hu
 FavfOiAQEfRqpneLBcsyazF9QWA=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> Provide default values that are as close as possible to the
> values used by the guest's kernel.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

