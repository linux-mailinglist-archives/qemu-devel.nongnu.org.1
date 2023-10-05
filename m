Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A94337B9AB9
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGHy-0004QO-QD; Thu, 05 Oct 2023 00:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGHp-0004PH-IQ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:48:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGHj-0004xv-KZ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:48:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so579518f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481303; x=1697086103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEu8DFMU5Cl5XdcFgyJYlxB88JAhCyhjDYbGgtRefHk=;
 b=xe1AL2GlNqfzcYHZG6pNiJuEEh1DD6Q71+NlUaQHdl1C8/nZYnocTnwnAETO1s5S/g
 jHwqcUUEEjXQYwzzhwxrwWkzqyj2kMma3lf9vYng4Q0RGcS2DlpSRHiE5YnstFulB5kw
 BH52eLOzWqRj6SoJbcV9MUBKLUe6etnz+tyVNq/eQhy1maGHnGzOl01QENCtrrzq2Fvn
 cLkZP1FxkI2iKOGWCWphsvD19fpu+J5UC0laDgJI7QlOkokojfJWXHEv3dvAHrcHmXVC
 qRP9TMWGmbZi2SOanWXL1R1LAV5QopfIBKDiF35LJluP277Y7ASRsUuuEJEO/oXvz2zP
 PPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481303; x=1697086103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEu8DFMU5Cl5XdcFgyJYlxB88JAhCyhjDYbGgtRefHk=;
 b=wYxF69BcPBOx/n1vOTkTA8pgEs9sI9MjYnlHoUfGF6aAE0hx24JXGLJPG4FEgomu6M
 S5CZ6MxzabBC2HZmTZ2Q5Zx/7ywdZLoZUp25d5k86AgX31vFnskys9UlL2NBCSRXx9og
 Qxo/iU/OMj5MSqyMwWyXy/gUDqfLoOf23kopIhk9/NxZ0oyAxDl9sD3EkNocOD9oZWSR
 espy13YSKkSBX8v8DYe8adRQ3Cr6jcPd6WyQu+xZrm2I4RSbFTOl6JnSrPW148ltDYGA
 IHcl/Q1RHQJreVUCzdzLdt6bDnDBaOX8VUmYcO53DtZRclOYVCI+GSGzJ1NbgAKXZUeu
 Ux1Q==
X-Gm-Message-State: AOJu0YyBfFTBsXqQ5Di2dE3ZmJtPW8EzQAC9wVp8rxEW7VqZ/g7DWmgF
 sft8VHeWUZTu/tsABzI+jNYF/w==
X-Google-Smtp-Source: AGHT+IGmv1gvqAHaOnGc/W1TuGt4u1tEy/+m+BLRFzIXIgaZUQE6CrP2Wq/VyS+m0NkQpEoB0CGmNw==
X-Received: by 2002:a5d:628a:0:b0:320:bb1:5a73 with SMTP id
 k10-20020a5d628a000000b003200bb15a73mr4064517wru.22.1696481303426; 
 Wed, 04 Oct 2023 21:48:23 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a5d58c6000000b0031aef72a021sm741618wrf.86.2023.10.04.21.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 21:48:23 -0700 (PDT)
Message-ID: <3984cd72-931b-fa9b-e7ac-3d60487ac442@linaro.org>
Date: Thu, 5 Oct 2023 06:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL 0/9] Python patches
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>
References: <20231004194613.2900323-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004194613.2900323-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi John,

On 4/10/23 21:46, John Snow wrote:
> The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-10-03 07:43:44 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> 
> for you to fetch changes up to 4d7a663cbe8343e884b88e44bd88d37dd0a470e5:
> 
>    Python: test Python 3.12 (2023-10-04 15:19:00 -0400)
> 
> ----------------------------------------------------------------
> Python pullreq
> 
> Buffering improvements for qemu machine, minor changes to support the
> newly released Python 3.12
> 
> ----------------------------------------------------------------
> 
> John Snow (9):
>    Python/iotests: Add type hint for nbd module
>    python/machine: move socket setup out of _base_args property
>    python/machine: close sock_pair in cleanup path
>    python/console_socket: accept existing FD in initializer
>    python/machine: use socketpair() for console connections
>    python/machine: use socketpair() for qtest connection
>    python/machine: remove unused sock_dir argument
>    python/qmp: remove Server.wait_closed() call for Python 3.12
>    Python: test Python 3.12

Is that a pull request or a patch series to be reviewed?

