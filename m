Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A1BE0C09
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 23:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98eH-0000nM-EJ; Wed, 15 Oct 2025 17:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v98eD-0000mz-UG
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:03:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v98e9-0007jM-6K
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:03:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2907948c1d2so331415ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760562175; x=1761166975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CV1TiBradwipw5WDIrk2stvOrDDm0HgdwRKKykoah5E=;
 b=ndof9fx+joeaUb9YHGRVRyO5JWt7yKKtYsiaBRoG48ywSS98N/EWKlf2609VfzdFuS
 p19exXCIyhqhlRCoYfEKWGO2gmk4DGZm9vbD0z8IZ7HZRSLSXZdH/8WDhwjjTE+ISqrP
 bEB0Rc0/gyDg001HM4k+VPJwheQ5rooJcO61HOueb2HK72JdGHj2shA18uoEjUWgT8gj
 06JkXhxCh37nvYHL0piAa9ogcz5jojgWxVwD6xAveulWsi+mYxK9YGXargmcE5s02rOV
 /kh6q4yQZBFUSV5LixAna8+grqC2k77qyYT8v15P1R3S3+wR70cnXrkSum4C+73ACXFC
 4Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760562175; x=1761166975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CV1TiBradwipw5WDIrk2stvOrDDm0HgdwRKKykoah5E=;
 b=LcqIcvfLLYTUH1WhJP/pcaBmJb/BrQbDtDSMD0oT8niK8l2m5llJIWe+f63bQ7McGD
 qwnjgU686dyU1M5EUzmu7euseQ7wni5Jm25kOfSDItoHyEQIRs3AknXv49+Ws6JdhrO2
 1BdnAHM/HQ2fo8wKO0aTQvhfZd1PALleNX56C+vX1MfGgu0sO5SvDi/KRP/45zq3bQ0K
 yZS+uylnQztWace1SN29q9X/OqvacuLdG75nkTKeI8mSefT3wrZqNgBXYJLTco8I8PSD
 PHg+4i5h0ukiI+MqG2XvqvRZGlp8F+Gcp2PkWVa2DP++rTIvBTTlUnto4FPodqG72bI8
 mwzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKoRp39NjbBzQfPs6gga7e0DHQqcWGeuCNaMTf4Vv6Myfi82XKpN5WLi4nGS0G2FC6bJSmPLs6sEDt@nongnu.org
X-Gm-Message-State: AOJu0YxdtogIfxAvH55PXMoSG/4FolYkOguX3QyZJHKkexH1K4AV/sQL
 Twjke1CDyXCoIJ0IuVbhoch80iyM0l4IKqYjaqpyroHP9YNd7MTF37Iqup5Y8vcOAVU=
X-Gm-Gg: ASbGncvrSa55hzFf9rt9VNimcMaodHzRcrfl5DUBJNaHoqyuqOp7myXa4Aoft4BKo1C
 dnJI+KEvYuMXUKBvqkgu1Am2SgRFjfZVTEHJ+PMyKOsQvCZFy/zq3EmU5wgtV4NHrim7m89lNVc
 hSdK5OVRLwkNRhy/NIS+y3E0Q9JjSI33EyZBGshIf6C/3n6MDxKPgOV2n1udeZwtHkxkbwEweU4
 ncYQDTlqnFneo22Tn+qdq+zLZN7cw+gV8TQQcylc1iSBpSFkftNUf2HzI9dQbEU/X8leBEjdi4S
 rxcZuxEMhSMsqbi+4S/uGvauIxU7MiBAW25iG28dYBFAjf08iTWhFACB75wtLSA53Gpbf50zMO8
 Me2UnxYIHyfNtdcKIdiqY9cya7GzVjlnfs60Wrv8OM7v8qwFVWGGDX4Ht68h1MaWYyrZYeKKdVb
 YpqJXYzJ5BwOFHQ+t9rdoXSpopyuY=
X-Google-Smtp-Source: AGHT+IEH8eUhEiZXDDX6wzWaF69/iGI3QsQ6uMyQRRszYTza7PJTeouK0bEaRvovlxTyyvVvRyas4A==
X-Received: by 2002:a17:902:ecc9:b0:262:2ae8:2517 with SMTP id
 d9443c01a7336-290272135e0mr426323645ad.5.1760562175224; 
 Wed, 15 Oct 2025 14:02:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099388dbasm5874715ad.47.2025.10.15.14.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 14:02:54 -0700 (PDT)
Message-ID: <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org>
Date: Wed, 15 Oct 2025 14:02:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug files
 to map symbols to source
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
 <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/15/25 1:40 PM, Philippe Mathieu-Daudé wrote:
> On 13/10/25 23:39, Pierrick Bouvier wrote:
>> Enhance uftrace_symbols.py to generate .dbg files, containing
>> source location for every symbol present in .sym file.
>> It allows to use uftrace {replay,dump} --srcline and show origin of
> 
> `uftrace {replay,dump} --srcline`
> 
>> functions, connecting trace to original source code.
>>
>> It was first implemented with pyelftools DWARF parser, which was way
>> to slow (~minutes) to get locations for every symbol in the linux
> 
> s/to/too/
> 
>> kernel. Thus, we use addr2line instead, which runs in seconds.
>>
>> As well, there were some bugs with latest pyelftools release,
>> requiring to run master version, which is not installable with pip.
>> Thus, since we now require binutils (addr2line), we can ditch pyelftools
>> based implementation and simply rely on nm to get symbols information,
> 
> `nm`
> 
>> which is faster and better.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    contrib/plugins/uftrace_symbols.py | 108 +++++++++++++++++++----------
>>    1 file changed, 72 insertions(+), 36 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>> index b49e03203c8..728bf04ce54 100755
>> --- a/contrib/plugins/uftrace_symbols.py
>> +++ b/contrib/plugins/uftrace_symbols.py
>> @@ -1,7 +1,7 @@
>>    #!/usr/bin/env python3
>>    # -*- coding: utf-8 -*-
>>    #
>> -# Create symbols and mapping files for uftrace.
>> +# Create symbols, debug and mapping files for uftrace.
>>    #
>>    # Copyright 2025 Linaro Ltd
>>    # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> @@ -9,44 +9,71 @@
>>    # SPDX-License-Identifier: GPL-2.0-or-later
>>    
>>    import argparse
>> -import elftools # pip install pyelftools
>>    import os
>> +import subprocess
>>    
>> -from elftools.elf.elffile import ELFFile
>> -from elftools.elf.sections import SymbolTableSection
>> +class Symbol:
>> +    def __init__(self, name, addr, size):
>> +        self.name = name
>> +        # clamp addr to 48 bits, like uftrace entries
>> +        self.addr = addr & 0xffffffffffff
>> +        self.full_addr = addr
>> +        self.size = size
>>    
>> -def elf_func_symbols(elf):
>> -    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
>> -                  if isinstance(s, SymbolTableSection)]
>> -    symbols = []
>> -    for _, section in symbol_tables:
>> -        for _, symbol in enumerate(section.iter_symbols()):
>> -            if symbol_size(symbol) == 0:
>> -                continue
>> -            type = symbol['st_info']['type']
>> -            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
>> -                symbols.append(symbol)
>> -    symbols.sort(key = lambda x: symbol_addr(x))
>> +    def set_loc(self, file, line):
>> +        self.file = file
>> +        self.line = line
>> +
>> +def get_symbols(elf_file):
>> +    symbols=[]
>> +    try:
>> +        out = subprocess.check_output(['nm', '--print-size', elf_file],
>> +                                      stderr=subprocess.STDOUT,
>> +                                      text=True)
> 
> Nitpicking, we might be using cross-compiled `nm`, so maybe not hardcode
> the binary name.
> 
>> +    except subprocess.CalledProcessError as e:
>> +        print(e.output)
>> +        raise
>> +    out = out.strip().split('\n')
>> +    for line in out:
>> +        info = line.split(' ')
>> +        if len(info) == 3:
>> +            # missing size information
>> +            continue
>> +        addr, size, type, name = info
>> +        # add only symbols from .text section
>> +        if type.lower() != 't':
>> +            continue
>> +        addr = int(addr, 16)
>> +        size = int(size, 16)
>> +        symbols.append(Symbol(name, addr, size))
>> +    symbols.sort(key = lambda x: x.addr)
>>        return symbols
>>    
>> -def symbol_size(symbol):
>> -    return symbol['st_size']
>> -
>> -def symbol_addr(symbol):
>> -    addr = symbol['st_value']
>> -    # clamp addr to 48 bits, like uftrace entries
>> -    return addr & 0xffffffffffff
>> -
>> -def symbol_name(symbol):
>> -    return symbol.name
>> +def find_symbols_locations(elf_file, symbols):
>> +    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
>> +    try:
>> +        out = subprocess.check_output(['addr2line', '--exe', elf_file],
> 
> Ditto (cross compiled)?
> 
>> +                                      stderr=subprocess.STDOUT,
>> +                                      input=addresses, text=True)
>> +    except subprocess.CalledProcessError as e:
>> +        print(e.output)
>> +        raise
>> +    out = out.strip().split('\n')
>> +    assert len(out) == len(symbols)
>> +    for i in range(len(symbols)):
>> +        s = symbols[i]
>> +        file, line = out[i].split(':')
>> +        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
>> +        # remove this to keep only line number.
>> +        line = line.split(' ')[0]
>> +        s.set_loc(file, line)
>>    
>>    class BinaryFile:
>>        def __init__(self, path, map_offset):
>>            self.fullpath = os.path.realpath(path)
>>            self.map_offset = map_offset
>> -        with open(path, 'rb') as f:
>> -            self.elf = ELFFile(f)
>> -            self.symbols = elf_func_symbols(self.elf)
>> +        self.symbols = get_symbols(self.fullpath)
>> +        find_symbols_locations(self.fullpath, self.symbols)
>>    
>>        def path(self):
>>            return self.fullpath
>> @@ -56,7 +83,7 @@ def addr_start(self):
>>    
>>        def addr_end(self):
>>            last_sym = self.symbols[-1]
>> -        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
>> +        return last_sym.addr + last_sym.size + self.map_offset
>>    
>>        def generate_symbol_file(self, prefix_symbols):
>>            binary_name = os.path.basename(self.fullpath)
>> @@ -66,14 +93,21 @@ def generate_symbol_file(self, prefix_symbols):
>>                # print hexadecimal addresses on 48 bits
>>                addrx = "0>12x"
>>                for s in self.symbols:
>> -                addr = symbol_addr(s)
>> +                addr = s.addr
>>                    addr = f'{addr:{addrx}}'
>> -                size = f'{symbol_size(s):{addrx}}'
>> -                name = symbol_name(s)
>> +                size = f'{s.size:{addrx}}'
>>                    if prefix_symbols:
>> -                    name = f'{binary_name}:{name}'
>> +                    name = f'{binary_name}:{s.name}'
>>                    print(addr, size, 'T', name, file=sym_file)
>>    
>> +    def generate_debug_file(self):
>> +        binary_name = os.path.basename(self.fullpath)
>> +        dbg_file_path = f'./uftrace.data/{binary_name}.dbg'
> 
> Prefer os.path.join().
> 
>> +        with open(dbg_file_path, 'w') as dbg_file:
>> +            for s in self.symbols:
>> +                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
>> +                print(f'L: {s.line} {s.file}', file=dbg_file)
>> +
>>    def parse_parameter(p):
>>        s = p.split(":")
>>        path = s[0]
>> @@ -84,7 +118,7 @@ def parse_parameter(p):
>>        offset = s[1]
>>        if not offset.startswith('0x'):
>>            err = f'offset "{offset}" is not an hexadecimal constant. '
>> -        err += 'It should starts with "0x".'
>> +        err += 'It should start with "0x".'
>>            raise ValueError(err)
>>        offset = int(offset, 16)
>>        return path, offset
>> @@ -124,7 +158,8 @@ def generate_map(binaries):
>>    
>>    def main():
>>        parser = argparse.ArgumentParser(description=
>> -                                     'generate symbol files for uftrace')
>> +                                     'generate symbol files for uftrace. '
>> +                                     'Require binutils (nm and addr2line).')
>>        parser.add_argument('elf_file', nargs='+',
>>                            help='path to an ELF file. '
>>                            'Use /path/to/file:0xdeadbeef to add a mapping offset.')
>> @@ -145,6 +180,7 @@ def main():
>>    
>>        for b in binaries:
>>            b.generate_symbol_file(args.prefix_symbols)
>> +        b.generate_debug_file()
>>    
>>        generate_map(binaries)
>>    
> No blocking comments:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Thanks Philippe.

For the cross compiled tools, I'm not really sure it's worth making this 
more complex. Having tooling for a cross architecture is an advanced 
setup, and I think it's fair to expect someone to have binutils 
installed if they have any cross compiler and cross binutils.
Plus, they can always create a symlink if needed.

Alex, can you eventually integrate the (other) cosmetic changes?
If not, I can send a new patch if you prefer.

Thanks,
Pierrick

