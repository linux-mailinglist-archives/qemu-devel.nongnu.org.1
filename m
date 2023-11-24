Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C27F71F1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:46:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Tgk-0002mi-CB; Fri, 24 Nov 2023 05:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r6Tgi-0002m4-Ph
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:45:32 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r6Tgg-0005Kz-M5
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:45:32 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-332e42469f0so865043f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700822728; x=1701427528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+JqoKFgiwFxpw1knhALGKhQFjoVEMUmZ/BZGjk7bF7Q=;
 b=i6Kf+zLcmGID7YtqbsfB2oY6sNydiMCiosJYa6+MCT9P1xVar+E11mN4MiAjIpEiAu
 YLQ1ObVyBCycf9vr5tFwahT59Chy/0uQRBKB1PyBOqYaF7+Umu+R7tCq2O3POLud7WLk
 Mbj1x5ClGrDbpSnZ2EY7DqTZWBvm8PCxJdm7Fk0dPwWFAj8hv63jIRQtio1dOssnAkln
 CGu8dya9XqY7dQpwq49m93h5avw7Raeu+h2fRM2i5A/f+/G/lLQc3Sbz2rG07szNnaQf
 HnKLzCBYNEBjZN7ucEyvb1qSu4DaUQawsrwuXbuHW0aUVqqIBnLVkcRUlVSZkhd1DE6E
 4H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822728; x=1701427528;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JqoKFgiwFxpw1knhALGKhQFjoVEMUmZ/BZGjk7bF7Q=;
 b=QrIDdIWop1zXvyINGPmcXXAUirN1rSnTBs5r/L29Le+V9MTq/P0EF1AmNuHJ9UhWkp
 UQjOmtD8ApIptiSg+M5hSwOnMQgYgzR4566qCIEmcqG2DmGcd7tfz8b3y3mLfICD6MVF
 ChcSblkqIuGR9OPT3bnPpGBal0He2R75iC/0fevSgZLiL2YAtLUYxXVAQ3r4PrnTk05L
 Eu7u29cqYtmwnAm7B36dg+VnTvDOk+zi8w9GkD8b+nFBq6J9LI5TB48H/jzTkgq0N+qx
 bS35S69UGTio49W2wSzsbuLZu4W4lxCuuCS4bch4NXdImuiNrLnwTY7gUFrCSxlfCFhM
 Px5A==
X-Gm-Message-State: AOJu0YzGeUZ27REGN9mViqhITYtAiSZFDHl7JCsxoIoCzgOFEYfDio9X
 lbR6WtHnWiBV/ieYX3cMBxbtMA==
X-Google-Smtp-Source: AGHT+IHvlQIQtzI3aJtHX7973loRzZJUM0YAeEwgvJvB+ZKtBRhzHzFVoCWi3l+PIBgabtLiHmyHBw==
X-Received: by 2002:a05:6000:b8b:b0:32f:9ac4:6f29 with SMTP id
 dl11-20020a0560000b8b00b0032f9ac46f29mr1819283wrb.70.1700822728178; 
 Fri, 24 Nov 2023 02:45:28 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 o10-20020adfcf0a000000b00332cb5185edsm3992338wrj.14.2023.11.24.02.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:45:27 -0800 (PST)
Date: Fri, 24 Nov 2023 12:42:50 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
User-Agent: meli 0.8.4
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org> <ZWB6M6w9yqAeemyi@redhat.com>
In-Reply-To: <ZWB6M6w9yqAeemyi@redhat.com>
Message-ID: <4mj7p.m1344a94mzib@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 24 Nov 2023 12:25, Kevin Wolf <kwolf@redhat.com> wrote:
>Am 23.11.2023 um 15:56 hat Manos Pitsidianakis geschrieben:
>> On Thu, 23 Nov 2023 16:35, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrangé wrote:
>> > > There has been an explosion of interest in so called "AI" (LLM)
>> > > code generators in the past year or so. Thus far though, this is
>> > > has not been matched by a broadly accepted legal interpretation
>> > > of the licensing implications for code generator outputs. While
>> > > the vendors may claim there is no problem and a free choice of
>> > > license is possible, they have an inherent conflict of interest
>> > > in promoting this interpretation. More broadly there is, as yet,
>> > > no broad consensus on the licensing implications of code generators
>> > > trained on inputs under a wide variety of licenses.
>> > > 
>> > > The DCO requires contributors to assert they have the right to
>> > > contribute under the designated project license. Given the lack
>> > > of consensus on the licensing of "AI" (LLM) code generator output,
>> > > it is not considered credible to assert compliance with the DCO
>> > > clause (b) or (c) where a patch includes such generated code.
>> > > 
>> > > This patch thus defines a policy that the QEMU project will not
>> > > accept contributions where use of "AI" (LLM) code generators is
>> > > either known, or suspected.
>> > > 
>> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> > > ---
>> > >  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 40 insertions(+)
>> > > 
>> > > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
>> > > index b4591a2dec..a6e42c6b1b 100644
>> > > --- a/docs/devel/code-provenance.rst
>> > > +++ b/docs/devel/code-provenance.rst
>> > > @@ -195,3 +195,43 @@ example::
>> > >    Signed-off-by: Some Person <some.person@example.com>
>> > >    [Rebased and added support for 'foo']
>> > >    Signed-off-by: New Person <new.person@example.com>
>> > > +
>> > > +Use of "AI" (LLM) code generators
>> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > > +
>> > > +TL;DR:
>> > > +
>> > > +  **Current QEMU project policy is to DECLINE any contributions
>> > > +  which are believed to include or derive from "AI" (LLM)
>> > > +  generated code.**
>> > > +
>> > > +The existence of "AI" (`Large Language Model <https://en.wikipedia.org/wiki/Large_language_model>`__
>> > > +/ LLM) code generators raises a number of difficult legal questions, a
>> > > +number of which impact on Open Source projects. As noted earlier, the
>> > > +QEMU community requires that contributors certify their patch submissions
>> > > +are made in accordance with the rules of the :ref:`dco` (DCO). When a
>> > > +patch contains "AI" generated code this raises difficulties with code
>> > > +provenence and thus DCO compliance.
>> > > +
>> > > +To satisfy the DCO, the patch contributor has to fully understand
>> > > +the origins and license of code they are contributing to QEMU. The
>> > > +license terms that should apply to the output of an "AI" code generator
>> > > +are ill-defined, given that both training data and operation of the
>> > > +"AI" are typically opaque to the user. Even where the training data
>> > > +is said to all be open source, it will likely be under a wide variety
>> > > +of license terms.
>> > > +
>> > > +While the vendor's of "AI" code generators may promote the idea that
>> > > +code output can be taken under a free choice of license, this is not
>> > > +yet considered to be a generally accepted, nor tested, legal opinion.
>> > > +
>> > > +With this in mind, the QEMU maintainers does not consider it is
>> > > +currently possible to comply with DCO terms (b) or (c) for most "AI"
>> > > +generated code.
>> > > +
>> > > +The QEMU maintainers thus require that contributors refrain from using
>> > > +"AI" code generators on patches intended to be submitted to the project,
>> > > +and will decline any contribution if use of "AI" is known or suspected.
>> > > +
>> > > +Examples of tools impacted by this policy includes both GitHub CoPilot,
>> > > +and ChatGPT, amongst many others which are less well known.
>> > 
>> > 
>> > So you called out these two by name, fine, but given "AI" is in scare
>> > quotes I don't really know what is or is not allowed and I don't know
>> > how will contributors know.  Is the "AI" that one must not use
>> > necessarily an LLM?  And how do you define LLM even? Wikipedia says
>> > "general-purpose language understanding and generation".
>> > 
>> > 
>> > All this seems vague to me.
>> > 
>> > 
>> > However, can't we define a simpler more specific policy?
>> > For example, isn't it true that *any* automatically generated code
>> > can only be included if the scripts producing said code
>> > are also included or otherwise available under GPLv2?
>> 
>> The following definition makes sense to me:
>> 
>> - Automated codegen tool must be idempotent.
>> - Automated codegen tool must not use statistical modelling.
>
>How are these definitions related to your ability to sign the DCO?
>
>Kevin

This was a response to Michael's salient observation that AI and LLM are 
very vague and not clearly defined terms. I did not mention DCO at all.

Manos

