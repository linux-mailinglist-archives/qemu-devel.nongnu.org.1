Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCB74DDA2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIw04-000079-PS; Mon, 10 Jul 2023 14:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIw02-00006f-6S
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvzt-0004RS-Qk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689015152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lnky/QXb8LYV6QtOQ9ee9IKj2WteS6vbVaRDEK1xUfY=;
 b=Hf9c0c+J8FDT6emeo7OyEnp9iJAj5UOdWqBUn3NBOqZM2u/aUdHeDrG8gukiVNUpKqZ6JC
 vIJsl6yMXILT2UIZRPFJcPPfDZwXdpQeclc822y3hUdhuT6PpoA2FJ5kKuyAIgvgDFPQ10
 3nVez5xOLrTir5mucuV6XE531rCpclA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-DTliZy74OE2pHVWGQR0EDA-1; Mon, 10 Jul 2023 14:52:31 -0400
X-MC-Unique: DTliZy74OE2pHVWGQR0EDA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8db49267so30242975e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 11:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689015150; x=1691607150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lnky/QXb8LYV6QtOQ9ee9IKj2WteS6vbVaRDEK1xUfY=;
 b=TBCD0qGI8SEEO9QxVv5LojutT9oXJuhRw6R9NtyzKlEOZM4fleyeQRG4KoCm4HsB1O
 2c7gICrwIJx8rYDhobdXA97+yjFHGJeh54Dee8KcaN42v0pNiH8howNI9D3RdWbJgUBe
 by5uQPwHb7t2Sn0fZ+xsZzJW0Qc/jK3BfLmt/5fWLi2+Ibdhk1bbzvcvHiOJmRnhl7/d
 GWB8fHW/8tG7PPDw7ZvLkM/ILcGZKNnGPumkNP0+Y8HypUwvWVh5HPgP7Pzvq4e/cgOQ
 4r3ugteoTQU/7vZcFckMaueObKi6uZV4CoSxwlhkveszhz6+BX5lI0K3Qkgp5eAWX6Hw
 tFhw==
X-Gm-Message-State: ABy/qLZqdSaHjLybIt9+oOpgeMuM2PAw49D2Ox6IjE2+OmJsnbsnw7Em
 UmQwlda911XxIm9Q2bLWBX/w3De/PrNETN8LGVo30SogXveGZ5aegAYu3A9pHVJrW+s7xw2tnMs
 24EvPL5N7e3QXkFI=
X-Received: by 2002:a7b:ce0f:0:b0:3f9:b87c:10db with SMTP id
 m15-20020a7bce0f000000b003f9b87c10dbmr11273905wmc.3.1689015150222; 
 Mon, 10 Jul 2023 11:52:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCA53FOIi3K62VuZ8l5A/BhjVVTURw/ahtgcRHnh2laO64Q1VBG9vf0yXPtTT6Jcd2GsEfZw==
X-Received: by 2002:a7b:ce0f:0:b0:3f9:b87c:10db with SMTP id
 m15-20020a7bce0f000000b003f9b87c10dbmr11273893wmc.3.1689015149893; 
 Mon, 10 Jul 2023 11:52:29 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 u10-20020a7bcb0a000000b003fb739d27aesm10930895wmj.35.2023.07.10.11.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 11:52:29 -0700 (PDT)
Date: Mon, 10 Jul 2023 14:52:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 18801353760@163.com
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
Message-ID: <20230710145208-mutt-send-email-mst@kernel.org>
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
 <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 26, 2023 at 04:26:04PM +0800, Hawkins Jiawei wrote:
> It appears that my commit message and comments did not take this into
> account. I will refactor them in the v2 patch..

does not look like you ever sent v2.


