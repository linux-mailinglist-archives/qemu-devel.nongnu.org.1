Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96F7BBD6E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qooCj-0007Xl-1p; Fri, 06 Oct 2023 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qooCh-0007XC-BY
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qooCf-0006lp-GK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696611687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2y0r7PdErCL4kYRDJttm0vt9ZwqPRrqffxfY8hMmZlI=;
 b=jCXvlYdFwEt4RjDQ/0X/CzFZtz9kHOei+YD5iakETj241ijICYaav6Hbx1oVFRTs4B+z+C
 444gkQuuMav+wxdNiyWPaGryPzvOF7PHKQCEtGzSESSj9efesAq62gh1k2nc9FMsU8Itf6
 SQg/OdiUnRgQTXuhcB7fWEvMcdWmHfE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-bCh7t5xaPtmjygE7IIoDWA-1; Fri, 06 Oct 2023 13:01:25 -0400
X-MC-Unique: bCh7t5xaPtmjygE7IIoDWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E50A2810D62;
 Fri,  6 Oct 2023 17:01:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B43F170E9;
 Fri,  6 Oct 2023 17:01:23 +0000 (UTC)
Date: Fri, 6 Oct 2023 12:01:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v7 14/15] scripts: add python_qmp_updater.py
Message-ID: <4q5nlgbdizox46ey7sadxyysmey5tvqf7qkk5d67jng4xbku3i@mnsmpz3v25wg>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
 <20231006154125.1068348-15-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006154125.1068348-15-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 06, 2023 at 06:41:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> A script, to update the pattern
> 
>     result = self.vm.qmp(...)
>     self.assert_qmp(result, 'return', {})
> 
> (and some similar ones) into
> 
>     self.vm.cmd(...)
> 
> Used in the next commit
>     "python: use vm.cmd() instead of vm.qmp() where appropriate"
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/python_qmp_updater.py | 136 ++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100755 scripts/python_qmp_updater.py
> 
> diff --git a/scripts/python_qmp_updater.py b/scripts/python_qmp_updater.py
> new file mode 100755
> index 0000000000..494a169812
> --- /dev/null
> +++ b/scripts/python_qmp_updater.py
> @@ -0,0 +1,136 @@
> +#!/usr/bin/env python3
> +#
> +# Intended usage:
> +#
> +# git grep -l '\.qmp(' | xargs ./scripts/python_qmp_updater.py
> +#
> +
> +import re
> +import sys
> +from typing import Optional
> +
> +start_reg = re.compile(r'^(?P<padding> *)(?P<res>\w+) = (?P<vm>.*).qmp\(',
> +                       flags=re.MULTILINE)
> +
> +success_reg_templ = re.sub('\n *', '', r"""
> +    (\n*{padding}(?P<comment>\#.*$))?
> +    \n*{padding}
> +    (
> +        self.assert_qmp\({res},\ 'return',\ {{}}\)
> +    |
> +        assert\ {res}\['return'\]\ ==\ {{}}
> +    |
> +        assert\ {res}\ ==\ {{'return':\ {{}}}}
> +    |
> +        self.assertEqual\({res}\['return'\],\ {{}}\)
> +    )""")

We may find other patterns, but this is a nice way to capture the most
common ones and a simple place to update if we find another one.

I did a quick grep for 'assert.*return' and noticed things like:

tests/qemu-iotests/056:        self.assert_qmp(res, 'return', {})
tests/qemu-iotests/056:        self.assert_qmp(res, 'return', [])

This script only simplifies the {} form, not the []; but that makes
sense: when we are testing a command known to return an array rather
than nothing, we still want to check if the array is empty, and not
just that the command didn't crash.  We are only simplifying the
commands that check for nothing in particular returned, on the grounds
that not crashing was probably good enough, and explicitly checking
that nothing extra was returned is not worth the effort.

> +
> +some_check_templ = re.sub('\n *', '', r"""
> +    (\n*{padding}(?P<comment>\#.*$))?
> +    \s*self.assert_qmp\({res},""")
> +
> +
> +def tmatch(template: str, text: str,
> +           padding: str, res: str) -> Optional[re.Match[str]]:
> +    return re.match(template.format(padding=padding, res=res), text,
> +                    flags=re.MULTILINE)
> +
> +
> +def find_closing_brace(text: str, start: int) -> int:
> +    """
> +    Having '(' at text[start] search for pairing ')' and return its index.
> +    """
> +    assert text[start] == '('
> +
> +    height = 1
> +
> +    for i in range(start + 1, len(text)):
> +        if text[i] == '(':
> +            height += 1
> +        elif text[i] == ')':
> +            height -= 1
> +        if height == 0:
> +            return i

I might have referred to this as 'nest' or 'depth', as I tend to think
of nesting depth rather than nesting height; but it's not a
show-stopper to use your naming.

> +
> +    raise ValueError
> +
> +
> +def update(text: str) -> str:
> +    result = ''
> +
> +    while True:
> +        m = start_reg.search(text)
> +        if m is None:
> +            result += text
> +            break
> +
> +        result += text[:m.start()]
> +
> +        args_ind = m.end()
> +        args_end = find_closing_brace(text, args_ind - 1)
> +
> +        all_args = text[args_ind:args_end].split(',', 1)
> +
> +        name = all_args[0]
> +        args = None if len(all_args) == 1 else all_args[1]
> +
> +        unchanged_call = text[m.start():args_end+1]
> +        text = text[args_end+1:]
> +
> +        padding, res, vm = m.group('padding', 'res', 'vm')
> +
> +        m = tmatch(success_reg_templ, text, padding, res)
> +
> +        if m is None:
> +            result += unchanged_call
> +
> +            if ('query-' not in name and
> +                    'x-debug-block-dirty-bitmap-sha256' not in name and
> +                    not tmatch(some_check_templ, text, padding, res)):
> +                print(unchanged_call + text[:200] + '...\n\n')
> +
> +            continue

Feels a bit hacky - but if it does the job, I'm not too worried.

> +
> +        if m.group('comment'):
> +            result += f'{padding}{m.group("comment")}\n'
> +
> +        result += f'{padding}{vm}.cmd({name}'
> +
> +        if args:
> +            result += ','
> +
> +            if '\n' in args:
> +                m_args = re.search('(?P<pad> *).*$', args)
> +                assert m_args is not None
> +
> +                cur_padding = len(m_args.group('pad'))
> +                expected = len(f'{padding}{res} = {vm}.qmp(')
> +                drop = len(f'{res} = ')
> +                if cur_padding == expected - 1:
> +                    # tolerate this bad style
> +                    drop -= 1
> +                elif cur_padding < expected - 1:
> +                    # assume nothing to do
> +                    drop = 0
> +
> +                if drop:
> +                    args = re.sub('\n' + ' ' * drop, '\n', args)

Wow - you've done some nice work here to not just replace things but
to keep relevant style intact.

> +
> +            result += args
> +
> +        result += ')'
> +
> +        text = text[m.end():]
> +
> +    return result
> +
> +
> +for fname in sys.argv[1:]:
> +    print(fname)
> +    with open(fname) as f:
> +        t = f.read()
> +
> +    t = update(t)
> +
> +    with open(fname, 'w') as f:
> +        f.write(t)
> -- 
> 2.34.1
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


