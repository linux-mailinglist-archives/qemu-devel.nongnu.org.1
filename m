Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F567CBD34
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfG5-0006Qq-EU; Tue, 17 Oct 2023 04:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsfG0-0006Pd-Ie
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:16:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsfFk-0002b3-NS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:16:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso1608282b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697530594; x=1698135394; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hx2z0viKf2JU8QzOnmzjxLa0mxSXLXxZ3KRCUEbSLGE=;
 b=LWhJVFcDkYwjXA0DEKUzLffoPf4Kq2PAw1DtyUcqbSrE5KDP0BGQ78y46kO34rOyMd
 f5c+GzFrsQWjkGO7Y5diziYxsklOvW1sD3gCwTD88Z7ymWYQeq+w5+BtgtlP+DYwyXFH
 q+Eo5aFnHdQObeOarrDulHtoD4MN09Fw2wwfyfbx2fmndvvq6HgqDYm6bpZnKlnGkqME
 0TiXvCeD1DT5oDGk/qqZP4SwzTPd4Cs/ECH7W6otJljQYfs14XwH+iBPVKIU1PR1W3nN
 xg7BbPCK9H4Vn9CYnScjzl/E7YJtHgFLJD9zCYnbPhaNtRE2uU39mx49UdVI7ZOfQF5o
 dhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697530594; x=1698135394;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hx2z0viKf2JU8QzOnmzjxLa0mxSXLXxZ3KRCUEbSLGE=;
 b=E33yT/5JT9p5iXjZSj5KLtwQ9rV93EgGv2yL3DKz30ld44eRnLD01PwhOZiSbLO2LI
 eXnSdazLlM+ybp2UVx2bzdWDGR0jvJ/1ZIEErfG0pElBUA0RSlwud0bWol+WsRaJqNte
 AybjrkOKFdVOtOrEHvpcnWyrg+9i1EYUAMvhZ/2ePhm3ZuXPjOHNWUcbIf3HQXkmGcwZ
 QGfvoDOLoaeFGquT/GuR+xO7JKz8o/FxIo9adJmDUJexaN8GrdDR5aMVV+iK5/aXjyQV
 fx/ot67aDzXM8SAac4cAcWhe5eEYPWjbRBmHIKlB5HSlbTfU1EmLtOWj+QAF2djrZJsc
 DS1A==
X-Gm-Message-State: AOJu0YzqBZMXlTPCodcQfy634q/hM4OLsTrWW7NQm5twksFd6Pp5mqsG
 GQdDddRLedUdjiy48UiFgzBBb3TSdgll5LLvTRQ=
X-Google-Smtp-Source: AGHT+IGVz0l/sUxa+ddJZzq6plH0AmUNqpiJp3xVG3NRYe1srujEcbqTm8ObVgnAfQhhmRhFT85mTQ==
X-Received: by 2002:a05:6a00:9a8:b0:6bd:3ba8:e60e with SMTP id
 u40-20020a056a0009a800b006bd3ba8e60emr1562398pfg.22.1697530593979; 
 Tue, 17 Oct 2023 01:16:33 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006be0bd6a4d8sm830070pfj.36.2023.10.17.01.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 01:16:33 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:46:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Message-ID: <20231017081631.iyxkf46zulsk3lrr@vireshk-i7>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
 <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
 <50116c43-5fb6-ad87-a748-12e02d596c13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50116c43-5fb6-ad87-a748-12e02d596c13@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=viresh.kumar@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17-10-23, 10:14, Hanna Czenczek wrote:
> On 17.10.23 09:53, Viresh Kumar wrote:
> > On 17-10-23, 09:51, Hanna Czenczek wrote:
> > > Not that I’m really opposed to that, but I don’t see the problem with just
> > > doing that in the same work that makes qemu actually use this flag, exactly
> > > because it’s just a -1/+1 change.

I should have replied here :)

> > > 
> > > I can send a v2, but should I do the same for libvhost-user and define the
> > > flag there?  Do I have to add a patch to do the same for F_STATUS, which so
> > > far only got a placeholder comment?
> > Sure, that's fine too.
> 
> I would rather not, though, and don’t see a tangible benefit in doing so.

Sorry for the miscommunication, I meant we can leave it as is for now
and let it be handled by the commit that uses it.

-- 
viresh

