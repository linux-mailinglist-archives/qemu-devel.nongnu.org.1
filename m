Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053778264AE
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 16:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMV07-00083v-KC; Sun, 07 Jan 2024 10:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMV05-00080s-06
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 10:23:45 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMV03-0006KV-BE
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 10:23:44 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55559e26ccfso1159015a12.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 07:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704641021; x=1705245821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sDI1snDzm899lfnhzHxRtD5F3BS1KrDqf9/aJ/b+nPc=;
 b=gZFpHlc8+e3sd1XRUo3YERV6ko199cLHxeJh/x/2T1+L9mF8OYlxQY46r+6Gu6nTyx
 heR5zkovwVLTwUCfnDB5lM2qPzLA1w5L16KROGSNbHRqCs7d06/eWWC8m/Te5QmDhlMt
 h8K3AuTvR+R6SxEmYa72+3qj0BJqsAobei5jWzb1YCGa5UWI+lctR5ZQqRMqFHQr250/
 05UQI7zIHx92gIEp2/KEaSAt4WseBcMpKFZ2p98A1m/XkpMABW3SGdQ2FdjWzIm1ieg6
 ip5+NvylY7Jo4Y5HevYvxvWTg4epnBijOMMEto4LS0jQeTE6ze9CgyWmYl7eSVz7D6F1
 PAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704641021; x=1705245821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDI1snDzm899lfnhzHxRtD5F3BS1KrDqf9/aJ/b+nPc=;
 b=U2FnpFfjOoWQ0ijSwNLYYOepGOYXumkAKNtNQ73spvsB/aAh+BpUXQZJca1YLx8qpH
 OtuzFzkUp2aEaFn7cLuEhdSiRApp/9zNRsj/cMfYgwIZVVPV8WVMz4REOj9IeqWac/QU
 PIVXyetZzKoFzQ++J2ktZpziqOpXD0ivZed2sD+o5xOSlNwmGvP8xitHd6C3JPv64xNy
 Cf3lsrzOSa3B0DwjhlbjgFpONfISXRl94F5oalp4TPwebAkHDYYomcpEp+XCsX6Sw9wc
 zsC5lrkRXrnRJQiz9owF0LxyVGov4x41lS7WwbiO/wuQXHGBagJEQlvOWqNQoHW90cvD
 9A7g==
X-Gm-Message-State: AOJu0YxewZSlj7HS3Gs/t3jsC5BC9rNk2Ap65lBP9Hm/XSqx7krtT33w
 IqJBpqOzMl7riiY82ywAapMSsvhbPzjGAeN1+7XOL9qhmgH8lQ==
X-Google-Smtp-Source: AGHT+IHMZn7NeAC/pacFlb/N6nTooQ7eaJbcxjUIppjnF6x3iQSrdPztKbKiL/nz3Zaf4IL4gGIvT2JFbGYYGxRLVXo=
X-Received: by 2002:a50:c056:0:b0:557:60a6:de62 with SMTP id
 u22-20020a50c056000000b0055760a6de62mr846207edd.50.1704641020895; Sun, 07 Jan
 2024 07:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
 <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
In-Reply-To: <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Jan 2024 15:23:07 +0000
Message-ID: <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Steve Sistare <steven.sistare@oracle.com>, Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 7 Jan 2024 at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > > I notice that your gpg key doesn't seem to be signed by anybody
> > > else; you might look at whether it's easy to get it signed
> > > by somebody else (eg some of your redhat colleagues).
> >
> > Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> > server we normally use?  Maybe I missed some steps there?
>
> Yes, Peter's key is signed by me:
>
> $ gpg --list-signatures 3B5FCCCDF3ABD706
> pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
>       Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
> uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
> sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> <stefanha@redhat.com>
> uid                   [  full  ] Peter Xu <peterx@redhat.com>
> sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> <stefanha@redhat.com>
> sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
> sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
>
> I have pushed to the keyservers again in case I forget.

Thanks. Which keyservers did you use? I think these days the
keyserver infrastructure is unfortunately fragmented; I
probably didn't try refreshing from the right keyserver.

-- PMM

