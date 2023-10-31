Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FE7DC96E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:25:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkz7-0001L3-Pa; Tue, 31 Oct 2023 05:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxkz5-0001KA-M0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxkz3-0002cz-VZ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698744264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woKrOysrOrC1SWStiNpxdwatfSSjIfIlJruyK1fc/60=;
 b=eOtKw4G/E6zJ+5Ks/aMYfrvws5kkowq2MSLFKGopDciu4kzp9wlsurr5lRdbAfBcz5y1Va
 Z5Sg9OIvIId6+BMagqouKd3J/slXzy9OeIehwrbMEC+hovylIBWxT0agSSOSUGnmdKHZBk
 8tB7CQfjBwk3PvfGqWr0TUraT71mtPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-mkb9a3BnOV6SRPZMMOxaMQ-1; Tue, 31 Oct 2023 05:24:22 -0400
X-MC-Unique: mkb9a3BnOV6SRPZMMOxaMQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so2783334f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 02:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698744261; x=1699349061;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=woKrOysrOrC1SWStiNpxdwatfSSjIfIlJruyK1fc/60=;
 b=JjARQOEOlLOGLrNjd3YeiqFxpz3bbgf6M21HI/wbq433YtPrks2HLGP5ChrqP3Tj6g
 sT4BmfprD5iSIIGCtm2hq2b5TXWlgNy6KlC80JLjWVppdBXJ/lAXivgZY/KqGwn6JhBo
 HBhivLRErbLy900lsE4IDPhElJC8PIVQmtwQxXb5rvw+vKHMWpLJdbfspVi3Od8IjlJB
 nsO4ydIhccvD2FV519Q5VYP72m9PEJLiAfxJS3M3BZXbUvowOTSd7rBZmV8nUCwUnGB+
 RGF2B+TFO7Az+GJp/j5s6vRjU7zJyJHv/eyMRMcE+IQe5hAJnrYuWerMcIMGw9dAGi7F
 HCWQ==
X-Gm-Message-State: AOJu0YwsFdnCma5xyv3NBadv8S8Aa9Tyl/xP6YzCqwrt7TpqxCOTDhFy
 sBljDv0EROFcOGfvwk2kuyRoyDevdLKj0pD7VI6kDPJhr7NNoxp8tZyY7ZpMuaad5u4VpPuriVf
 wBQkEdjFGvCoCybA=
X-Received: by 2002:a05:6000:70b:b0:32d:8b1a:31ad with SMTP id
 bs11-20020a056000070b00b0032d8b1a31admr12739398wrb.24.1698744261225; 
 Tue, 31 Oct 2023 02:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ7Ew+69odUXGI98eYjnj+nJldNy0h5yRX30mB+BY2HtznIzyM93PYlskqaB6by8XE5VWHPw==
X-Received: by 2002:a05:6000:70b:b0:32d:8b1a:31ad with SMTP id
 bs11-20020a056000070b00b0032d8b1a31admr12739380wrb.24.1698744260814; 
 Tue, 31 Oct 2023 02:24:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 dh17-20020a0560000a9100b00318147fd2d3sm904350wrb.41.2023.10.31.02.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 02:24:20 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------3cXnwnGCc0XsOclLpiI1Apfy"
Message-ID: <56a64662-ce50-4ab0-92e5-d23abdcb7358@redhat.com>
Date: Tue, 31 Oct 2023 10:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/file-posix: fix update_zones_wp() caller
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: hare@suse.de, Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 stefanha@redhat.com, qemu-block@nongnu.org, dmitry.fomichev@wdc.com
References: <20230825040556.4217-1-faithilikerun@gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230825040556.4217-1-faithilikerun@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------3cXnwnGCc0XsOclLpiI1Apfy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.08.23 06:05, Sam Li wrote:
> When the zoned request fail, it needs to update only the wp of
> the target zones for not disrupting the in-flight writes on
> these other zones. The wp is updated successfully after the
> request completes.
>
> Fixed the callers with right offset and nr_zones.
>
> Signed-off-by: Sam Li<faithilikerun@gmail.com>
> ---
>   block/file-posix.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied to my block branch:

https://gitlab.com/hreitz/qemu/-/commits/block

(Rebased on master, and I’ve also fixed the comment to read “boundaries” 
instead of “bounaries”.  Hope that’s OK!)

Hanna
--------------3cXnwnGCc0XsOclLpiI1Apfy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 25.08.23 06:05, Sam Li wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230825040556.4217-1-faithilikerun@gmail.com">
      <pre class="moz-quote-pre" wrap="">When the zoned request fail, it needs to update only the wp of
the target zones for not disrupting the in-flight writes on
these other zones. The wp is updated successfully after the
request completes.

Fixed the callers with right offset and nr_zones.

Signed-off-by: Sam Li <a class="moz-txt-link-rfc2396E" href="mailto:faithilikerun@gmail.com">&lt;faithilikerun@gmail.com&gt;</a>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
</pre>
    </blockquote>
    <br>
    Thanks, applied to my block branch:<br>
    <br>
    <a class="moz-txt-link-freetext" href="https://gitlab.com/hreitz/qemu/-/commits/block">https://gitlab.com/hreitz/qemu/-/commits/block</a><br>
    <br>
    (Rebased on master, and I’ve also fixed the comment to read
    “boundaries” instead of “bounaries”.  Hope that’s OK!)<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------3cXnwnGCc0XsOclLpiI1Apfy--


