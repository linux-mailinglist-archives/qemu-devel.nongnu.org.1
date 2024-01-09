Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C3828F5B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:00:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNK88-0000jQ-Bp; Tue, 09 Jan 2024 16:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rNK85-0000jI-Ac
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:59:26 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rNK83-0007p3-Aq
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1704837557; bh=sq7HBpU2k4EP/4RkOG6Bn59dhftr2Ynq3EaaJkEy8EM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r2ldAvb88vb1CTMfPG/RqQZzETvMCC0m2rtWjRosi+7I+6oi2hYJexSpAbJEvnjQV
 BXkl4nidYkebo/ZrP8VsA+Z+O1qvRL1vz5JdDGJ8fvGbAxE9Fs8MTQkdJeZMZOpUYy
 0dG6EI7zkuptlcHQQLhT8CA0Vs5hji/Am9jFF3EM=
Date: Tue, 9 Jan 2024 22:59:17 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: Re: [PATCH v2 0/2] linux-user: two fixes to coredump generation
Message-ID: <f7ece567-1d04-4ab6-b41f-9ca32d0b4f2f@t-8ch.de>
References: <20240107-qemu-user-dumpable-v2-0-54e3bcfc00c9@t-8ch.de>
 <26f604c1-f3e6-4ae8-a502-a7b92c1c1d30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26f604c1-f3e6-4ae8-a502-a7b92c1c1d30@linaro.org>
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
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

On 2024-01-10 08:33:11+1100, Richard Henderson wrote:
> On 1/8/24 01:01, Thomas Weißschuh wrote:
> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> > ---
> > Changes in v2:
> > - Rebase on 8.2 master
> > - Resend after closed tree and holidays
> > - Link to v1: https://lore.kernel.org/r/20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de
> > 
> > ---
> > Thomas Weißschuh (2):
> >        linux-user/elfload: test return value of getrlimit
> >        linux-user/elfload: check PR_GET_DUMPABLE before creating coredump
> > 
> >   linux-user/elfload.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 0c1eccd368af8805ec0fb11e6cf25d0684d37328
> > change-id: 20231115-qemu-user-dumpable-d499c0396103
> > 
> > Best regards,
> 
> Both patches look good for correctness, but both have style issues: need
> braces on those if statements.
> 
> With that fixed,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks,

I added the braces for the next revision, which I'll send after waiting
some more feedback.

