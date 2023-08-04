Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9FD76FE4C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrtW-0002ty-Ta; Fri, 04 Aug 2023 06:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrtU-0002tO-By
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:18:52 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrtS-00046b-T3
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144328; x=1691749128; i=deller@gmx.de;
 bh=CPZYEetpVxVI2MQ4UhIGDYCOhiqzQIZ42q06HHrDTsk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BX2dNVQFCSQD4vAiILEAfzj/wkufkdamGIOaKoFJ/V7GeFfNVLNG2ut/aaGwxQgLFYgH5Xy
 D60mV8+wH8tGR43NO+5e12BZd+bK7gLQPhkACQSvzs/r+3bz40PbnjHRxOfEVhTDR3aH3qgOn
 wwRNFlzlzlGdWu/g5LSBgvX91yNaDCfUjS9Kc422HXmJL1XlQyDaET381Drwa6PdixxMg6Po3
 CM4U/hIy8H8pbWBVrZZybbDbcPy00BDiFEMW0M9fwPOTvPNg4HCfsXOXIwGayh1twJhw/VTph
 9v4iQQQW5QyzD5Jz6A4XqHZU9jopG8CpH56ac6a+11f6d+tGNpCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1q9vvs44xD-00JYOt; Fri, 04
 Aug 2023 12:18:48 +0200
Date: Fri, 4 Aug 2023 12:18:46 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 11/17] linux-user: Use MAP_FIXED_NOREPLACE for initial
 image mmap
Message-ID: <ZMzQhmyMkFp4n2F/@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-12-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:D8T6C+ZbYqKqX+sL7eI/7y7DOT+ISwWAjq12JF6IhfwNU3c94L7
 wdgqOXPUHfvzs7W74pawR1hhIbaR2OnuUVZhyqAQjBNUCiJ98FrS20BpHLdLpwIt9uwY9Xf
 Uu14uiD1J2qwLfebO4tSGHHC25n0a/Ky98Ue96gCDsmp/VDVI10ufW5cxjlgqR5XpXLVG23
 8uHS5OEWF6lJID2071SeQ==
UI-OutboundReport: notjunk:1;M01:P0:ml5RDfLzks4=;xGk+qy9m4lPK5knqD3tv9RpKrKH
 ycKyw/FMto0fjpoe6SjNqr3iCRgrPELIEnz6SZovoM6a8A9ReIVxt77SMYqgcz9KcLhuId+Q5
 m1DsbyIpbCK/Czuke3Cm2Qdfz3w2r4D/b5cQP57gejnLiZTm0N4XbYxxOkJGt+MyBkKFwlv6u
 BBOZey8TtyOySADUmySlORzAfJJ0D0OP/a8iV996zEbGhjsM96S6ntx8b+Ss0l26ciyOGyND4
 muhdJZHRBh7O+jMDhx62K6RBYkl/e+5OYBXYFMy2Kf5Q11JIJrYL2d4WY4SwpQhmmPH9zBigR
 tf+wMUv1tCXhWsXUgTGKYNOKWVhkx7ZhCeVuIsrrdErHmXuxl+GeDhTnGjuHqH6bzX0JFhnyp
 WsMPhjRSqF6b/JgaATjj5tSO3ys88ATnsaCvR2UF0gnV2De3mblyzatsHOrb1CsXSsITG+abr
 eSH8vbOznq+xMmTt9EyFrBekgnTxZ8FpzHDZdWRgtZOwi7464c+aciIrrT41Z1E4nX/u+UPH8
 t6i2Xkm7FAsG9Os9WLClgZ9ZERh74VFpFola/mjaaZpAbvZD7JsleIFcZ4LKrE3NN8aI2unwQ
 yCi/5lji2xOUgUlk6DZTAcENev0KQ1G6mnr5J2XREq4Ut5Ys7IkCyQev4Kklbdhc8+Gu+4h7G
 NbwNmrGuxqXBWrZ6fPLZX+gZclnvEkiahv9aN+YzHGk5B5yxcF2vP/2veTba8zRIoZWmb5s+6
 KSX87CnObvwkMhrmHNpO6yGvMK5t6Ha9u7zeqFGFy/4tz7KNNb0jZycTrUtVPip9+pl4Hz2F3
 fY/icA+eTx7oB3Nytk2jvLVW6DxnvXe+8cwF7wA6zsU2g451Rdb8Mm2pihy5xJOmzq93HzVw1
 Qvf8tm6jA4SSsPg/eobY3uybXwq39jmi6pinBr3nRKgoWvNS5cAtFUGFYC6ALgILrwd7Vqa4a
 w7BWvZTxj4Acr+OsSlCZquPEPI8=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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
> Use this as extra protection for the guest mapping over
> any qemu host mappings.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

